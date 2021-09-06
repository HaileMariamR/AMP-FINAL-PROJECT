import UserModel from "../Models/User.js";
// Update User Account



export const updateProfile = async (httpreq, httpres) =>{
  try {

    const updateInfo = httpreq.body;
    const checkuser = await UserModel.findOne({
      emailAddress: updateInfo.emailAddress,
    });
    console.log(checkuser);
    if (checkuser) {
      await  UserModel.updateOne(checkuser, { $set: updateInfo });
      return httpres.status(201).send("Succesfully updated!");
    } else {
      return httpres.status(400).send("User doesnt exist");
    }
  } catch (error) {}
}

// Delete User Account

export const  deleteProfile = async (httpreq, httpres)=> {

  

  try {
    const getuser = httpreq.body;

    const checkuser = await UserModel.findOne({
      emailAddress: getuser.emailAddress,
    });

    if (checkuser) {
      await UserModel.deleteOne({ emailAddress: checkuser.emailAddress });
      console.log("Deleted!")
      return httpres.status(200).send("Succesfully Deleted!");
    } else {
      return httpres.status(400).send("User doesnt exist");
    }
  } catch (error) {}
}
