FROM golang:bookworm AS build 
WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY . . 
RUN CGO_ENABLED=0  go build -o main .

FROM gcr.io/distroless/static-debian13
WORKDIR /app
COPY --from=build  /app/main ./
COPY --from=build /app/static ./static
EXPOSE 8080
CMD ["./main"]
