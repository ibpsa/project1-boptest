export default function errorHandler(err, req, res, next) {
  if (err.mapped) {
    res.status(400).send(err.mapped())
  } else {
    next(err)
  }
}
