FROM ubuntu
RUN apt-get update && apt-get install -y unar tzdata
RUN echo "America/New_York" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata
COPY . /
ENTRYPOINT ["/extractor.sh"]
CMD ["/extract"]
