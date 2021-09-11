import mongoose from 'mongoose';
import  Schema   from 'mongoose';


const ScheduleFields = {

  createdby: {
    type: Schema.Types.ObjectId,
    ref:'Representative',
    required: true,
  },
  
  dateofcreation: {
    type: Date,
    default: Date.now,
  },
  programs: [{
    type: String,
    default: null,
    required: true,
  }],

};


const ScheduleSchema = mongoose.Schema(ScheduleFields , {timestamps:true});
const ScheduleModel = mongoose.model("Schedule", ScheduleSchema);

export default ScheduleModel