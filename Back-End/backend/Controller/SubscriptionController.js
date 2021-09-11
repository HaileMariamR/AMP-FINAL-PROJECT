import UserModel from "../Models/User.js";


export const Subscribe = async (httpreq, httpres) => {
    try {
      
        const subscriberInfo = httpreq.body;
        const representativeid = subscriberInfo['representativeid'];
        const appuserid = subscriberInfo['appuserid']

        const checkuser = await UserModel.findOne({
            _id: representativeid,
          });

        
        if( checkuser){
            const getAppUser = await UserModel.findOne({
                _id:appuserid ,
              });

              const index = checkuser.allsubscriber.indexOf(appuserid);

              if( index == -1){
            checkuser.allsubscriber.push(getAppUser);
            await checkuser.save()
            getAppUser.allsubscription.push(checkuser);
            await  getAppUser.save()
              }
              
            return httpres.status(201).json({ message: " Sucessfully Subscribed" });

        }

            return httpres
              .status(400)
              .json({ message: "failed" });
        
    } catch (error) {

        console.log(error); 
    }
};
export const unSubscribe = async (httpreq, httpres) => {

  try {
    const subscriberInfo = httpreq.body;
    const representativeid = subscriberInfo['representativeid'];
    const appuserid = subscriberInfo['appuserid']
    const checkuser = await UserModel.findOne({
        _id: representativeid,
      });
    if( checkuser){
        const getAppUser = await UserModel.findOne({
            _id:appuserid ,
          });
       

            checkuser.allsubscriber.pull(getAppUser);
            await checkuser.save()
            getAppUser.allsubscription.pull(checkuser);
            await getAppUser.save();
    
          return httpres.status(201).json({ message: " Sucessfully UnSubscribe" });
    }

        return httpres
          .status(400)
          .json({ message: "failed" });
    
} catch (error) {

    console.log(error);
    
}
};




  