const {sendSuccess} = require('../../utils/formatResponse');
const logger = require('../../utils/logger');

const {
    Role,
    Permission,
    RolePermission,
    sequelize,
    Sequelize,
  } = require('../models');
  const {BadRequest,NotFound} = require('../../utils/httpErrors');
  const {ROLE_CODES} = require('../../constants/constants');

  const update = async (req, res, next) => {
    try {
      const { roleId } = req.params;
      // const { roleName, roleCode, permissions } = req.body;
      const { permissions } = req.body;

  
      const role = await Role.findOne({
        where: { id: roleId },
        include: [{ model: RolePermission, as: 'RolePermissions' }],
      });
  
      if (!role) {
        throw new NotFound('Role not found');
      }
  
      // if (roleCode) {
      //   const roleWithCodeExist = await Role.findOne({ where: { roleCode } });
  
      //   if (roleWithCodeExist) {
      //     throw new BadRequest(`Role with code already exists`);
      //   }
      // }
  
      if (permissions) {
        const retrievedPermissions = await Permission.findAll({
          where: { id: permissions },
        });
  
        if (permissions.length !== retrievedPermissions.length) {
          throw new BadRequest('One or more permissions are invalid.');
        }
      }
  
      await sequelize.transaction(async (t) => {
        // const dataToUpdate = {
        //   ...(roleName ? { roleName } : {}),
        //   ...(roleCode ? { roleCode } : {}),
        // };
  
        // if (Object.keys(dataToUpdate).length > 0) {
        //   await Role.update(dataToUpdate, {
        //     where: { id: roleId },
        //     transaction: t,
        //   });
        // }
  
        if (permissions) {
          const rolePermissionsIds = role.RolePermissions.map(
            (rolePermission) => rolePermission.permissionId
          );
  
          const permissionsIdsToDelete = rolePermissionsIds.filter(
            (rolePermissionId) => !permissions.includes(rolePermissionId)
          );
  
          const permissionsIdsToCreate = permissions.filter(
            (permissionId) => !rolePermissionsIds.includes(permissionId)
          );
  
          if (permissionsIdsToDelete.length > 0) {
            const deletePermissions = permissionsIdsToDelete.map(
              async (rolePermissionToDelete) => {
                const rolePermission = role.RolePermissions.find(
                  (rolePermission) =>
                    rolePermission.permissionId === rolePermissionToDelete
                );
  
                await RolePermission.destroy({
                  where: { id: rolePermission.id },
                  transaction: t,
                });
              }
            );
            await Promise.all(deletePermissions);
          }
  
          if (permissionsIdsToCreate.length > 0) {
            const createPermission = permissionsIdsToCreate.map(
              async (rolePermissionId) => {
                await RolePermission.create(
                  { roleId: role.id, permissionId: rolePermissionId },
                  { transaction: t }
                );
              }
            );
            await Promise.all(createPermission);
          }
        }
      });
  
      return res
        .status(200)
        .json(sendSuccess('Role permissions updated successfully'));
    } catch (error) {
      logger.info(error.message);
      return next(error);
    }
  };


  const findAll = async (req, res, next) => {
    try {
      const roles = await Role.findAll({
        //where: { roleCode: { [Sequelize.Op.ne]: ROLE_CODES.ADMIN } },
      });
      return res.json(sendSuccess('Roles retrieved successfully', roles));
    } catch (error) {
      logger.info(error.message);
      return next(error);
    }
  };

  const findRolesAdmin = async (req, res, next) => {
    try {
      const roles = await Role.findAll({
        where: { roleCode: { [Sequelize.Op.ne]: ROLE_CODES.ADMIN } },
      });
      return res.json(sendSuccess('Roles retrieved successfully', roles));
    } catch (error) {
      logger.info(error.message);
      return next(error);
    }
  };

  const getRolePermissions = async (req, res, next) => {
    try {
      const { roleId } = req.params;
      
  
      const role = await Role.findOne({
        where: { id: roleId },
        include: [
          {
            model: RolePermission,
            as: 'RolePermissions',
            include: [{ model: Permission, as: 'Permission' }],
          },
        ],
      });
  
      if (!role) {
        throw new NotFound('Role not found');
      }
  
      const { RolePermissions, ...roleData } = role.get({ plain: true });
  
      const permissions = RolePermissions.map(
        (rolePermission) => rolePermission.Permission
      );
  
      return res.json(
        sendSuccess('Roles permissions retrieved successfully', {
          ...roleData,
          permissions,
        })
      );
    } catch (error) {
      logger.info(error.message);
      return next(error);
    }
  };

  module.exports = {findAll,update,getRolePermissions,findRolesAdmin};