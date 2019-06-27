package homework3

import homework3.html.HtmlUtils
import homework3.http._
import homework3.math.Monoid

import scala.annotation.tailrec
import scala.concurrent.duration.Duration
import scala.concurrent.{Await, ExecutionContext, Future}

case class SpideyConfig(maxDepth: Int,
                        sameDomainOnly: Boolean = true,
                        tolerateErrors: Boolean = true,
                        retriesOnError: Int = 0)

class Spidey(httpClient: HttpClient)(implicit ex: ExecutionContext) {
  def crawl[O: Monoid](url: String, config: SpideyConfig)
                      (processor: Processor[O]): Future[O] = {
    processRec(List(url), Set.empty, 0, Future.successful(Monoid[O].identity), config, processor)
  }

  @tailrec
  private final def processRec[O: Monoid](urls: List[String], visited: Set[String], depth: Int, acc: Future[O], config: SpideyConfig, processor: Processor[O]): Future[O] = {
    val futureResponses: List[Future[HttpResponse]] = urls.map(url => httpClient.get(url))

    // TODO: do not await for all, but process each request as it gets ready
    val httpResponses: List[HttpResponse] = Await.result(Future.sequence(futureResponses), Duration(5, "s"))

    val processed: Future[O] = httpResponses
      .map(x => processor.apply(x.url, x))
      .reduce((x, y) => zipMap(x, y, Monoid[O].op))

    val currentResult = zipMap(acc, processed, Monoid[O].op)

    if (depth == config.maxDepth) currentResult
    else {
      val nextLevel: List[String] = getNextLevel(httpResponses, visited)
      processRec(nextLevel, visited ++ urls, depth + 1, currentResult, config, processor)
    }
  }

  def getLinks(url: String, response: HttpResponse, visited: Set[String]): List[String] =
    HtmlUtils.linksOf(response.body, url).distinct
      .filter(HttpUtils.isValidHttp)
      .filter(!visited(_))

  def getNextLevel(responses: List[HttpResponse], visited: Set[String]): List[String] =
    responses
      .filter(_.isHTMLResource)
      .flatMap(response => getLinks(response.url, response, visited))

  def zipMap[A, B, C](fa: Future[A], fb: Future[B], f: (A, B) => C): Future[C] =
    fa.zip(fb).map(f.tupled)
}
