const express = require('express');

const rolesRouter = require('./role_route');
const userRouter = require('./user_route');
const authRouter = require('./authRouter');
const permissionsRouter = require('./permission_route');
const planningSowingRouter = require('./planningRoute');
const costRecordsRouter = require('./costRecord_route');
const inventoryRouter = require('./inventory_route');
const profitabilityRouter = require('./profitability_route');
const reportsRouter = require('./report_route');


const router = express.Router();



module.exports = router;
router.use('/roles', rolesRouter);
router.use('/users',userRouter);
router.use('/auth',authRouter);
router.use('/permissions', permissionsRouter);
router.use('/planning-sowing',planningSowingRouter);
router.use('/cost-records',costRecordsRouter);
router.use('/inventory', inventoryRouter);
router.use('/profitability', profitabilityRouter);
router.use('/reports', reportsRouter);


module.exports = router;