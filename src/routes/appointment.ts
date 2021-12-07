import express from 'express';
import controller from '../controllers/appointment';

const router = express.Router();

router.get('/patient', controller.getByPatient);
router.get('/doctor', controller.getByDoctor);
router.post('/', controller.postAppointment);

export = router;
