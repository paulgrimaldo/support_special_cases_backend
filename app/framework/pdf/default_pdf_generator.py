from weasyprint import HTML
import io

from app.domain.html_renderer import HtmlRenderer
from app.framework.config.wkhtmltopdf_config import pdf_options

class DefaultPdfGenerator:
    def __init__(self, html_renderer: HtmlRenderer):
        self.html_renderer = html_renderer

    def generate(self, data):
        rendered_html = self.html_renderer.render(data)
        
        pdf_buffer = io.BytesIO()
        HTML(string=rendered_html).write_pdf(pdf_buffer)
        pdf_data = pdf_buffer.getvalue()
        pdf_buffer.close()
        
        return pdf_data