import ScheduleModel from "../Models/Schedule.js";
import UserModel from "../Models/User.js";
import RepresentativeModel  from "../Models/Representative.js";

export const createSchedule = async (httpreq, httpres) => {
  
  try {
    const postedSchedule = httpreq.body;
    const schedule = new ScheduleModel(postedSchedule);
    await schedule.save();
    console.log(schedule);

    const creator = await RepresentativeModel.findById({
      _id: postedSchedule.createdby,
    });
    creator.postedSchedules.push(schedule);  
    await creator.save();   
     
    if (schedule) {
      return httpres.status(201).json({ message: "Schedule Created" });
    } else {
      return httpres
        .status(400)
        .json({ message: "Sorry Failed to Create Schedule." });
    }
  } catch (error) {
    console.log(error);
  }
};


export const deleteSchedule = async (httpreq, httpres) => {
  try {  
    const getparams = httpreq.query.id;

    const finalParameter = getparams.slice(10, getparams.length - 2);

    const findSchedule = await ScheduleModel.findById({ _id: finalParameter });

    if (findSchedule) {
      await ScheduleModel.deleteOne({ _id: finalParameter });
      return httpres.json({ Message: "Succesfully Deleted" });
    }

    return httpres.status(404).send(`failed!`);
  } catch (error) {
    console.log(error);
  }
};

export const updateSchedule = async (httpreq, httpres) => {
  try {
    const updateInfo = httpreq.body;

    const checkSchedule = await ScheduleModel.findOne({
      _id: updateInfo._id,
    });

    if (checkSchedule) {
      await ScheduleModel.updateOne(checkSchedule, { $set: updateInfo });
      return httpres.status(201).send("Succesfully updated!");
    } else {
      return httpres.status(400).send("Schedule Doesnt exist");
    }
  } catch (error) {
    console.log(error);
  }
};

export const getallSchedules = async (httpreq, httpres) => {
  try {
    const schedules = await ScheduleModel.find();
    if (schedules != null) {
      return httpres.status(200).json({ Schedules: schedules });
    } else {
      return httpres.status(400).send("Sorry, didnt get any schedule!");
    }

    // return httpres.status(200).json({"message":"schedules"})
  } catch (error) {
    console.log(error);
  }
};

