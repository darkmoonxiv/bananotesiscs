const express = require('express');
const {
    signin, getToken, resetPasswordRequest,resetPassword,updateInfo, updatePassword
} = require('../controllers/auth_controller');
const authRouter = express.Router();
const validateRequest = require('../middlewares/validateRequest');
const validateAuthorizationToken = require('../middlewares/validateAuthorizationToken');
const {
    signinSchema, resetPasswordRequestSchema,resetPasswordSchema,updateInfoSchema
} = require('../validators/auth');




authRouter.post('/signin', validateRequest(signinSchema), signin);

authRouter.get('/', validateAuthorizationToken,getToken);

authRouter.put('/info',validateRequest(updateInfoSchema) ,validateAuthorizationToken,updateInfo);

authRouter.post(
    '/reset-password',
    validateRequest(resetPasswordRequestSchema),
    resetPasswordRequest
);

authRouter.put(
    '/reset-password/:token',
    validateRequest(resetPasswordSchema),
    resetPassword
);

authRouter.put(
    '/update-password',
    validateAuthorizationToken,
    updatePassword
)



module.exports = authRouter;