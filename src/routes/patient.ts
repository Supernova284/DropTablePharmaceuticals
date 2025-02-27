import express from 'express';
import controller from '../controllers/patient';

const router = express.Router();

router.get('/', controller.getAll);
router.get('/id', controller.getPatient);
router.post('/', controller.postPatient);

export = router;
