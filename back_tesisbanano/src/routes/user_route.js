const express = require('express');
const{
 findAll,findOne,update,create,destroy
} = require('../controllers/user_controller');
const validateRequest = require('../middlewares/validateRequest');
const validateAuthorizationToken = require('../middlewares/validateAuthorizationToken');
const validatePermission = require('../middlewares/validatePermission');

const {
  createUserSchema,
    updateUserSchema,
  } = require('../validators/user');

const userRouter = express.Router();

userRouter.get(
    '/',
    validateAuthorizationToken,
    findAll
)

userRouter.get(
    '/:userId',
    validateAuthorizationToken,
    // validateRole([ROLE_CODES.ADMIN]),
    validatePermission(['user.get']),
    findOne
  );

  userRouter.post(
    '/',
    validateAuthorizationToken,
    // validateRole([ROLE_CODES.ADMIN]),
    validatePermission(['user.create']),
    validateRequest(createUserSchema),
    create
  );

  userRouter.put(
    '/:userId',
    validateAuthorizationToken,
    // validateRole([ROLE_CODES.ADMIN]),
    validatePermission(['user.edit']),
    validateRequest(updateUserSchema),
    update
  );

  userRouter.delete(
    '/:userId',
    validateAuthorizationToken,
    validatePermission(['user.delete']),
    // validateRole([ROLE_CODES.ADMIN]),
    destroy
  );


module.exports = userRouter