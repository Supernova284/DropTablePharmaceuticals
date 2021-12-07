import express from 'express';
import controller from '../controllers/prescription';

const router = express.Router();

router.get('/', controller.getAll);
router.get('/id', controller.getPrescription);
router.post('/', controller.postPrescription);
router.put('/', controller.updatePrescription);

export = router;
