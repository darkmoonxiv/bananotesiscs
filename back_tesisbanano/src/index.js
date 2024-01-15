require('dotenv').config();
const express = require('express')
const helmet = require('helmet');
const cors = require('cors');
const logger = require('../utils/logger');
const router = require('./routes/indexRoutes');
const {HttpError} = require('../utils/httpErrors');
const {sendError} = require('../utils/formatResponse');

const app = express()

app.use(helmet());

app.use(cors());

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

const PORT = process.env.APP_PORT;
app.use('/v1', router)

app.use((err, req, res, next) => {
  logger.error(err);

  if (err instanceof HttpError) {
    return res
      .status(err.code)
      .json(sendError(err.code, err.message, err?.errors));
  }

  return res.status(500).json(sendError(500, 'Something went wrong'));
});

const startServer = () => {
  app.listen(PORT, () => {
    logger.info(`Server is running on port ${PORT}`);

  });
};

startServer();


