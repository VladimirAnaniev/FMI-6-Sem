package homework3.http

import java.nio.charset.{Charset, StandardCharsets}

import org.asynchttpclient.util.{HttpUtils => AsyncHttpUtils}

trait HttpResponse {
  def url: String
  def status: Int
  def headers: Map[String, String]
  def bodyAsBytes: Array[Byte]

  def body: String = {
    val charset = contentType.flatMap(_.charset).getOrElse(StandardCharsets.UTF_8)

    new java.lang.String(bodyAsBytes, charset)
  }

  def contentType: Option[ContentType] = headers.get("content-type").map { contentType =>
    val mimeType = contentType.split(";")(0).trim.toLowerCase
    val charset = Option(AsyncHttpUtils.extractContentTypeCharsetAttribute(contentType))

    ContentType(mimeType, charset)
  }

  def isSuccess: Boolean = 200 <= status && status < 300
  def isClientError: Boolean = 400 <= status && status < 500
  def isServerError: Boolean = 500 <= status && status < 600
  def isHTMLResource: Boolean = contentType.exists(ct => ct.mimeType.equals(ContentType.Html))
  def isPlainTextResource: Boolean = contentType.exists(ct => ct.mimeType.equals(ContentType.PlainText))
}

case class ContentType(mimeType: String, charset: Option[Charset])

object ContentType {
  val Html = "text/html"
  val PlainText = "text/plain"
}
