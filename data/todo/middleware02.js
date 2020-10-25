module.exports = (req, res, next) => {
  console.log(req.headers)
  if(!req.headers['x-api-key']) {
    res.status(401);
    res.send({ 401: 'Not authorized' });
    return;
  }
  next()
}
