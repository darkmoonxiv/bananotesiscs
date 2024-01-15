const express = require('express');
const {
    findAll,
    getRolePermissions,
    update,
    findRolesAdmin
  } = require('../controllers/role_controller');
  const roleRouter = express.Router();

  const { updateRoleSchema } = require('../validators/role');
  const validateAuthorizationToken = require('../middlewares/validateAuthorizationToken');
  const validatePermission = require('../middlewares/validatePermission');
  const validateRequest = require('../middlewares/validateRequest');

  roleRouter.get(
    '/findR',
    validateAuthorizationToken,
    validatePermission(['roles.list']),
    findRolesAdmin
  );

  roleRouter.get(
    '/',
    validateAuthorizationToken,
    validatePermission(['roles.list']),
    findAll
  );

  roleRouter.get(
    '/:roleId/permissions',
    validateAuthorizationToken,
    // validateRole([ROLE_CODES.ADMIN]),
    validatePermission(['roles.get_permissions']),
    getRolePermissions
  );


  roleRouter.put(
    '/:roleId',
    validateAuthorizationToken,
    // validateRole([ROLE_CODES.ADMIN]),
    validatePermission(['roles.set_permissions']),
    validateRequest(updateRoleSchema),
    update
  );
  

  module.exports = roleRouter;