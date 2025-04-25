FROM golang:1.24.2-alpine3.21 AS build

WORKDIR /app

COPY go.mod .

RUN go mod tidy

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o /bin/app

FROM scratch

WORKDIR /app

COPY --from=build /bin/app .

CMD [ "./app" ]