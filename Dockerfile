FROM debian:latest

WORKDIR /backend

ENV FLASK_APP=main.py
ENV FLASK_DEBUG=1
# ENV XDG_RUNTIME_DIR=/tmp/xdg

# RUN mkdir -p /tmp/xdg && \
#     chmod 0700 /tmp/xdg

# RUN apt-get update && \
#     apt-get install -y \
#         xvfb \
#         xfonts-100dpi \
#         xfonts-75dpi \
#         xfonts-scalable \
#         wkhtmltopdf \
#         python3 \
#         python3-pip \
#         python3-venv && \
#     apt-get clean && \
#     rm -rf /var/lib/apt/lists/*
RUN apt-get update && \
    apt-get install -y \
        weasyprint \
        python3 \
        python3-pip \
        python3-venv \
        curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
# RUN printf '#!/bin/bash\nxvfb-run -a --server-args="-screen 0, 1024x768x24" /usr/bin/wkhtmltopdf -q $*' > /usr/bin/wkhtmltopdf.sh
# RUN chmod a+x /usr/bin/wkhtmltopdf.sh

ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV:$PATH"

COPY requirements.txt .
RUN pip install --upgrade pip --break-system-packages && \
    pip install -r requirements.txt --break-system-packages

COPY . .

EXPOSE 5000

CMD [ "python3", "-m", "flask", "run", "--host=0.0.0.0" ]
