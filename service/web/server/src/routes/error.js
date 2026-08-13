export function errorHandler(err, req, res, next) {
  if (err instanceof Error) {
    console.log(err.stack)
    res.status(500).send(err.message)
  } else {
    next(err)
  }
}
