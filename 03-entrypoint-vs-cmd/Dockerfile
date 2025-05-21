FROM alpine:3.21

WORKDIR /app

RUN addgroup -g 1000 appgroup && \
    adduser -u 1000 -G appgroup -D appuser

RUN apk upgrade && \
    apk add ffmpeg

COPY convert.sh .

RUN chmod +x convert.sh

ENTRYPOINT [ "./convert.sh" ]
# CMD [ "" ]