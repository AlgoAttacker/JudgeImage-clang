FROM alpine:3

COPY solver.sh /solver.sh

RUN apk add --no-cache gcc libc-dev su-exec
RUN chmod +x /solver.sh
RUN adduser -D solver

CMD sleep infinity
