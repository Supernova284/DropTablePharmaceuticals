import express from 'express';
import controller from '../controllers/doctor';

const router = express.Router();

router.get('/doctor', controller.getAll);
router.get('/doctor/patient', controller.getPatientDoctor);
router.post('/doctor', controller.postDoctor);

export = router;
