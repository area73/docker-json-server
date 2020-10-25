module.exports = (req, res, next) => {
  res.header('X-Company', 'Cabify')
  next()
}
