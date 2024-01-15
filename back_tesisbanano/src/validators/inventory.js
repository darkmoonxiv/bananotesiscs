const Joi = require('joi');

const createInventorySchema = Joi.object({
  body: Joi.object({
    codigo:Joi.string().required(),
    purchaseDate: Joi.date().required(),
    description: Joi.string().required(),
    medida: Joi.string().valid('LITRO', 'GALON','NINGUNO','FUNDAS','SACOS').required(),
    product: Joi.string().required(),
    quantity: Joi.number().integer().positive().required(),
    unitPrice: Joi.number().required(),
  }),
}).unknown(true);

const updateInventorySchema = Joi.object({
  body: Joi.object({
    codigo:Joi.string(),
    purchaseDate: Joi.date(),
    description: Joi.string(),
    medida: Joi.string().valid('LITRO', 'GALON','NINGUNO','FUNDAS','SACOS'),
    product: Joi.string(),
    quantity: Joi.number().integer().positive(),
    unitPrice: Joi.number(),
  }).or('codigo','purchaseDate','description','medida', 'product', 'quantity', 'unitPrice'),
}).unknown(true);

module.exports = {
  createInventorySchema,
  updateInventorySchema,
};
