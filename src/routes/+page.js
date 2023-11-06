import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

// export const ssr = false;
export async function load() {

  // const { username, email } = req.body;
  // let username = "astems";
  // let email = "cyberpark00002@astems.co.kr";
  // // let jdata = {
  // //   name: "cyberpark",
  // //   age: 35,
  // //   location: "Seoul, South Korea",
  // //    };

  // let jdata = {"BILL_INFO":[
  //   {"ORDER_ITEM":
  //     [
  //       {"GOODS_CD":"GD0001","GOODS_NM":"몬스터와퍼","QTY":1,
  //         "SUBITEM": 
  //           [
  //             {"GOODS_CD":"GD0004","GOODS_NM":"양파","QTY":-1,"PROC_TYPE":1},
  //             {"GOODS_CD":"GD0005","GOODS_NM":"양상추","QTY":-1,"PROC_TYPE":1},
  //             {"GOODS_CD":"GD0006","GOODS_NM":"할라피뇨","QTY":1,"PROC_TYPE":2},
  //             {"GOODS_CD":"GD0007","GOODS_NM":"치즈1장","QTY":1,"PROC_TYPE":2},
  //             {"GOODS_CD":"GD0008","GOODS_NM":"아메리카노","QTY":1,"PROC_TYPE":3}
  //           ]
  //       },
  //       {"GOODS_CD":"GD0002","GOODS_NM":"기네스머쉬룸와퍼","QTY":2},
  //       {"GOODS_CD":"GD0003","GOODS_NM":"너겟킹4조각","QTY":3}
  //     ]
  //   },
  //   {"ORDER_NUM":"ORD001"},
  //   {"ORDER_DATE":"20231012"},
  //   {"ORDER_TYPE":"eat-in"},
  //   {"SALE_DATE":"20231012"},
  //   {"POS_NO":"01"},
  //   {"BILL_NO":"0001"}, 
  //   {"MEMO":"양파/양상추 제외하고, 할라피뇨/치즈 추가 음료는 아메리카노로 변경"}
  // ]};
  
 
  // let id = 1;
 
  // try {
  //   const newUser = await prisma.user.create({
  //   // const newUser = await prisma.user.update({
  //     // where: { id: Number(id) },
  //     data: {
  //       name: username, 
  //       email: email,
  //       updatedAt: new Date(),        
  //       jsondata: jdata
  //     } 
  //   }); 

  //   console.log("success!!\n%s",newUser)

  //   // res.end(JSON.stringify({ message: 'User created successfully', user: newUser }));
  // } catch (error) {
  //   // res.statusCode = 500;
  //   // res.end(JSON.stringify({ error: 'Internal server error' }));
  //   console.log("error!!:%s",error) 
  // }  

  const orderCTE = await prisma.orders.findMany({
    where: {
      ORDER_NO: '20231101NC0001010001',
      PARENT_GOODS_CD: null,
    },
    select: {
      ORDER_NO: true,
      GOODS_CD: true,
      GOODS_NM: true,
      PARENT_GOODS_CD: true,
      LINE_NO: true,
      QTY: true,
      LEVEL: 0,
    },
  });

  const orderCTEWithChildren = await prisma.orders.findMany({
    where: {
      ORDER_NO: '20231101NC0001010001',
      PARENT_GOODS_CD: { not: null },
    },
    select: {
      ORDER_NO: true,
      GOODS_CD: true,
      GOODS_NM: true,
      PARENT_GOODS_CD: true,
      LINE_NO: true,
      QTY: true, 
      LEVEL: true,
    },
  });

  // Perform necessary operations with the data retrieved

  return { orderCTE, orderCTEWithChildren };

}
 
// load()
//   .catch(e => {
//     console.log("catch error!!")
//     throw e
//   })
//   .finally(async () => {
//     console.log("disconnected!!")
//     await prisma.$disconnect()
//   }) 