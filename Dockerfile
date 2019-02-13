FROM ubuntu
WORKDIR /app
RUN apt-get update && apt-get install -y unar tzdata
RUN echo "America/New_York" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata
COPY extractor.sh .
ENTRYPOINT ["/app/extractor.sh"]
CMD ["/extract"]
