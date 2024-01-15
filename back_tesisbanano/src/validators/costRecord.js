const Joi = require('joi');

const findAllCostRecordSchema = Joi.object({
  query: Joi.object({
    startDate: Joi.date(),
    endDate: Joi.date(),
    operationalUserId: Joi.number().integer(),
  }),
}).unknown(true);

const createCostRecordSchema = Joi.object({
  body: Joi.object({
    description: Joi.string().max(100).required(),
    input: Joi.number().required(),
    labor: Joi.number().required(),
    fuel: Joi.number().required(),
    totalCosts: Joi.number().required(),
  }),
}).unknown(true);

const updateCostRecordSchema = Joi.object({
  body: Joi.object({
    description: Joi.string().max(100),
    input: Joi.number(),
    labor: Joi.number(),
    fuel: Joi.number(),
    totalCosts: Joi.number(),
  }).or('description', 'input', 'labor', 'fuel', 'totalCosts'),
}).unknown(true);

module.exports = {
  findAllCostRecordSchema,
  createCostRecordSchema,
  updateCostRecordSchema,
};
