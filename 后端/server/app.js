// app.js
require("dotenv").config();
const express = require("express");
const bodyParser = require("body-parser");
const mysql = require("mysql");
const axios = require("axios");
const bcrypt = require("bcrypt");
//导入cors包
const cors = require('cors')
const app = express();
// 使用cors包解决跨域问题
app.use(cors())
app.use(bodyParser.json());
// console.log("Database Host:", process.env.DB_HOST);
// console.log("App ID:", process.env.WX_APPID);
// console.log("App Secret:", process.env.WX_SECRET);

// 使用环境变量来配置数据库连接
const db = mysql.createConnection({
  host: "122.9.184.225",
  user: "SHU01",
  password: "Shu123456",
  database: "medince",
});

db.connect((err) => {
  if (err) throw err;
  console.log("Database connected!");
});

// 微信登录API
app.post("/api/wechat-login", async (req, res) => {
  const { code } = req.body;
  const appid = process.env.WX_APPID; // 从环境变量获取AppID
  const secret = process.env.WX_SECRET; // 从环境变量获取AppSecret
  const url = `https://api.weixin.qq.com/sns/jscode2session?appid=${appid}&secret=${secret}&js_code=${code}&grant_type=authorization_code`;

  try {
    const response = await axios.get(url);
    if (response.data.openid) {
      // 你可能需要根据openid查找或创建一个用户，并生成一个自定义登录态
      res.send({
        success: true,
        user: {
          id: response.data.openid, // 示例，实际应用时应有更复杂的用户识别逻辑
          avatarUrl: "", // 你可以添加更多的用户信息
          nickName: "",
        },
        session_key: response.data.session_key,
      });
    } else {
      res.send({ success: false, message: "微信登录失败" });
    }
  } catch (error) {
    res
      .status(500)
      .send({ success: false, message: "服务器错误", error: error.message });
  }
});

// 登录或注册API
app.post("/api/login", (req, res) => {
  const { phone, password } = req.body;
  const sqlFindUser = "SELECT * FROM users WHERE phone = ?";
  db.query(sqlFindUser, [phone], async (err, results) => {
    if (err) {
      console.error("Database query error:", err);
      return res
        .status(500)
        .send({ success: false, message: "数据库查询错误" });
    }
    if (results.length > 0) {
      // 用户存在，验证密码
      const user = results[0];
      const passwordMatch = await bcrypt.compare(password, user.password);
      if (passwordMatch) {
        user.times = JSON.parse(user.times);
        const { password, ...userInfo } = user; // 剔除密码信息
        res.send({ success: true, user: userInfo });
      } else {
        res.send({ success: false, message: "密码错误" });
      }
    } else {
      // 用户不存在，创建新用户
      const hashedPassword = await bcrypt.hash(password, 10); // 加密密码
      const times = [];
      const sqlCreateUser = `
        INSERT INTO users 
        (username, name, email, phone, password, times) 
        VALUES (?, ?, ?, ?, ?, ?)`;
      const defaultEmail = `default@example.com`; // 示例邮箱，应调整为适当的值或从请求中获取
      db.query(
        sqlCreateUser,
        [
          phone,
          "New User",
          defaultEmail,
          phone,
          hashedPassword,
          JSON.stringify(times),
        ],
        (err, result) => {
          if (err) {
            console.error("Error creating user:", err);
            return res
              .status(500)
              .send({ success: false, message: "创建用户失败" });
          }
          const newUser = {
            id: result.insertId,
            username: phone,
            name: phone,
            email: defaultEmail,
            phone: phone,
            times,
          };
          res.send({ success: true, user: newUser });
        }
      );
    }
  });
});

//管理员登录
app.post("/api/adm/login", async (req, res) => {
  const { account, password } = req.body;
  const sql = "select password from adm where account=?";
  db.query(sql, [account], async (err, results) => {
    if (err) {
      console.error("Database query error:", err);
      return res
        .status(500)
        .send({ success: false, message: "数据库查询错误" });
    }
    if (results.length <= 0) {
      return res.send({ code: 1, msg: "账号不存在" });
    }
    let passwordMatch = results[0].password;
    const passwordFlag = await bcrypt.compare(password, passwordMatch);
    if (!passwordFlag) {
      return res.send({ code: 1, msg: "密码错误,请重新输入" });
    }
    return res.send({ code: 0, msg: "登录成功" });
  });
});

//查询数据
app.get("/api/adm/data", (req, res) => {
  const sql1 = "select count(*) as total from users";
  const sql2 = "select count(*) as total from drug_info";

  db.query(sql1, [], async (err, results) => {
    if (err) {
      console.error("Database query error:", err);
      return res
        .status(500)
        .send({ success: false, message: "数据库查询错误" });
    }
    let obj = {
      userCount: 0,
      drugCount: 0,
    };
    obj.userCount = results[0].total;
    db.query(sql2, [], async (err, result) => {
      if (err) {
        console.error("Database query error:", err);
        return res
          .status(500)
          .send({ success: false, message: "数据库查询错误" });
      }
      obj.drugCount = result[0].total;
      res.send({ code: 0, msg: "查询成功", data: obj });
    });
  });
});

//分页搜索
app.get('/api/adm/likeDrugs',(req, res)=>{
  let { pageNum, pageSize,name } = req.query;
  const sql = "select * from drug_info where name like ? limit ?,?";
  const sql2 = "select count(*) AS total from drug_info where name like ?";
  db.query(sql2, [`%${name}%`], async (err, results) => {
    if (err) {
      console.error("Database query error:", err);
      return res.status(500).send({ code: 1, msg: "数据库查询错误" });
    }
    db.query(sql, [`%${name}%`,(pageNum - 1) * pageSize, parseInt(pageSize)], async (err, result) => {
      if (err) {
        console.error("Database query error:", err);
        return res.status(500).send({ code: 1, msg: "数据库查询错误" });
      }
      let obj = {
        list: result,
        total: results[0].total,
      };
      res.send({
        code: 0,
        msg: "查询成功",
        data: obj,
      });
    });
  });
})

//分页查询所有药品
app.get("/api/adm/drugs", (req, res) => {
  let { pageNum, pageSize } = req.query;

  const sql = "select * from drug_info  limit ?,?";
  const sql2 = "select count(*) AS total from drug_info";
  db.query(sql2, [], async (err, results) => {
    if (err) {
      console.error("Database query error:", err);
      return res.status(500).send({ code: 1, msg: "数据库查询错误" });
    }
    db.query(sql, [(pageNum - 1) * pageSize, parseInt(pageSize)], async (err, result) => {
      if (err) {
        console.error("Database query error:", err);
        return res.status(500).send({ code: 1, msg: "数据库查询错误" });
      }
      let obj = {
        list: result,
        total: results[0].total,
      };
      res.send({
        code: 0,
        msg: "查询成功",
        data: obj,
      });
    });
  });
});

//删除指定的药品
app.delete("/api/adm/drugs/:id", (req, res) => {
  const did = req.params.id;
  const sql = "delete from drug_info where id=?";
  db.query(sql, [parseInt(did)], async (err, results) => {
    if (err) {
      console.error("Database delete error:", err);
      return res.status(500).send({ code: 1, msg: "数据库错误" });
    }

    res.send({
      code: 0,
      msg: "删除成功",
    });
  });
});

//修改指定药品
app.put("/api/adm/drugs", (req, res) => {
  let {
    id,
    name,
    description,
    indications,
    dosage,
    side_effects,
    usage_method,
    frequency_per_day,
  } = req.body;
  const sql =
    "update drug_info set name=?,description=?,indications=?,dosage=?,side_effects=?,usage_method=?,frequency_per_day=? where id=?";
  db.query(
    sql,
    [
      name,
      description,
      indications,
      dosage,
      side_effects,
      usage_method,
      frequency_per_day,
      id,
    ],
    async (err, results) => {
      if (err) {
        console.error("Database update error:", err);
        return res.status(500).send({ code: 1, msg: "操作数据库错误" });
      }
      res.send({
        code: 0,
        msg: "修改成功",
      });
    }
  );
});

//添加药品
app.post("/api/adm/drugs", (req, res) => {
  let {
    name,
    description,
    indications,
    dosage,
    side_effects,
    usage_method,
    frequency_per_day,
  } = req.body;

  const sql =
    "insert into drug_info(name,description,indications,dosage,side_effects,usage_method,frequency_per_day) values(?,?,?,?,?,?,?)";

  db.query(
    sql,
    [
      name,
      description,
      indications,
      dosage,
      side_effects,
      usage_method,
      frequency_per_day,
    ],
    async (err, results) => {
      if (err) {
        console.error("Database insert error:", err);
        return res.status(500).send({ code: 1, msg: "操作数据库错误" });
      }
      res.send({
        code: 0,
        msg: "添加成功",
      });
    }
  );
});

//查询所有用户
app.get("/api/adm/users", (req, res) => {
  let { pageNum, pageSize } = req.query;

  const sql = "select * from users  limit ?,?";
  const sql2 = "select count(*) AS total from users";
  db.query(sql2, [], async (err, results) => {
    if (err) {
      console.error("Database query error:", err);
      return res.status(500).send({ code: 1, msg: "数据库查询错误" });
    }
    db.query(sql, [(pageNum - 1) * pageSize, parseInt(pageSize)], async (err, result) => {
      if (err) {
        console.error("Database query error:", err);
        return res.status(500).send({ code: 1, msg: "数据库查询错误" });
      }
      let obj = {
        list: result,
        total: results[0].total,
      };
      res.send({
        code: 0,
        msg: "查询成功",
        data: obj,
      });
    });
  });
});

//分页搜索用户
app.get('/api/adm/likeUsers',(req, res)=>{
  let { pageNum, pageSize,name } = req.query;
  const sql = "select * from users where name like ? limit ?,?";
  const sql2 = "select count(*) AS total from users where name like ?";
  db.query(sql2, [`%${name}%`], async (err, results) => {
    if (err) {
      console.error("Database query error:", err);
      return res.status(500).send({ code: 1, msg: "数据库查询错误" });
    }
    db.query(sql, [`%${name}%`,(pageNum - 1) * pageSize, parseInt(pageSize)], async (err, result) => {
      if (err) {
        console.error("Database query error:", err);
        return res.status(500).send({ code: 1, msg: "数据库查询错误" });
      }
      let obj = {
        list: result,
        total: results[0].total,
      };
      res.send({
        code: 0,
        msg: "查询成功",
        data: obj,
      });
    });
  });
})


//修改指定的用户信息
app.put("/api/adm/user", async (req, res) => {
  const { id, username, name, email, phone, password } = req.body;
  const sql = `
    UPDATE users SET
    username = ?,
    name = ?,
    email = ?,
    phone = ?,
    password = ?
    WHERE id = ?`;
  const hashedPassword = await bcrypt.hash(password, 10);
  db.query(
    sql,
    [username, name, email, phone, hashedPassword, id],
    (err, result) => {
      if (err) {
        console.error("Failed to update user info:", err);
        res.status(500).send({
          code: 1,
          msg: "Failed to update user information.",
        });
      } else {
        console.log("Updated user info successfully.");
        res.send({
          code: 0,
          msg: "User information updated successfully.",
        });
      }
    }
  );
});

//查询所有反馈信息
app.get("/api/adm/feedbacks", (req, res) => {
  let { pageNum, pageSize } = req.query;
  const sql = "select * from feedbacks order by create_time desc  limit ?,?";
  const sql2 = "select count(*) AS total from feedbacks";
  db.query(sql2, [], async (err, results) => {
    if (err) {
      console.error("Database query error:", err);
      return res.status(500).send({ code: 1, msg: "数据库查询错误" });
    }
    db.query(sql, [(pageNum - 1) * pageSize, parseInt(pageSize)], async (err, result) => {
      if (err) {
        console.error("Database query error:", err);
        return res.status(500).send({ code: 1, msg: "数据库查询错误" });
      }
      let obj = {
        list: result,
        total: results[0].total,
      };
      res.send({
        code: 0,
        msg: "查询成功",
        data: obj,
      });
    });
  });
});

//用户反馈信息
app.post("/api/add/feedbacks", (req, res) => {
  let { title, content, dateTime, name, phone } = req.body;
  const sql =
    "insert into feedbacks(name,phone,title,content,status,create_time) values(?,?,?,?,?,?)";
  db.query(
    sql,
    [name, phone, title, content, 0, dateTime],
    async (err, results) => {
      if (err) {
        console.error("Database insert error:", err);
        return res.status(500).send({ code: 1, msg: "操作数据库错误" });
      }
      res.send({
        code: 0,
        msg: "添加成功",
      });
    }
  );
});

//处理反馈信息
app.put("/api/adm/feedbacks", (req, res) => {
  let { id } = req.body;
  const sql = `
  UPDATE feedbacks SET
  status = ?
  WHERE id = ?`;

  db.query(sql, [1, id], (err, result) => {
    if (err) {
      console.error("Failed to update feedbacks info:", err);
      res.status(500).send({
        code: 1,
        msg: "Failed to update feedbacks information.",
      });
    } else {
      res.send({
        code: 0,
        msg: "Feedbacks information updated successfully.",
      });
    }
  });
});

// 更新用户信息
app.post("/api/updateUserInfo", (req, res) => {
  const { id, username, name, email, phone, times } = req.body;

  const sql = `
    UPDATE users SET
    username = ?,
    name = ?,
    email = ?,
    phone = ?,
    times = ?
    WHERE id = ?`;

  db.query(sql, [username, name, email, phone, times, id], (err, result) => {
    if (err) {
      console.error("Failed to update user info:", err);
      res.status(500).send({
        success: false,
        message: "Failed to update user information.",
      });
    } else {
      console.log("Updated user info successfully.");
      res.send({
        success: true,
        message: "User information updated successfully.",
      });
    }
  });
});

// 重置密码API
app.post("/api/changePassword", (req, res) => {
  const { phone, oldPassword, newPassword } = req.body;

  // 根据手机号找到用户
  const sqlFindUser = "SELECT * FROM users WHERE phone = ?";
  db.query(sqlFindUser, [phone], async (err, results) => {
    if (err) {
      console.error("Database query error:", err);
      return res
        .status(500)
        .send({ success: false, message: "数据库查询错误" });
    }
    if (results.length > 0) {
      const user = results[0];
      const passwordMatch = await bcrypt.compare(oldPassword, user.password);
      if (passwordMatch) {
        const hashedNewPassword = await bcrypt.hash(newPassword, 10);
        const sqlUpdatePassword =
          "UPDATE users SET password = ? WHERE phone = ?";
        db.query(
          sqlUpdatePassword,
          [hashedNewPassword, phone],
          (err, result) => {
            if (err) {
              console.error("Failed to update password:", err);
              return res
                .status(500)
                .send({ success: false, message: "密码更新失败" });
            }
            res.send({ success: true, message: "密码更新成功" });
          }
        );
      } else {
        res.send({ success: false, message: "旧密码不正确" });
      }
    } else {
      res.status(404).send({ success: false, message: "用户不存在" });
    }
  });
});

//忘记密码api
app.post("/api/resetPassword", (req, res) => {
  const { name, phone, newPassword } = req.body;
  const hashedPassword = bcrypt.hashSync(newPassword, 10); // 对新密码进行加密

  // 验证用户信息
  const sql = "SELECT * FROM users WHERE name = ? AND phone = ?";
  db.query(sql, [name, phone], (err, results) => {
    if (err) {
      console.error("Database error:", err);
      return res.status(500).send({ success: false, message: "数据库错误" });
    }
    if (results.length > 0) {
      // 用户验证成功，更新密码
      const updateSql = "UPDATE users SET password = ? WHERE phone = ?";
      db.query(updateSql, [hashedPassword, phone], (err, result) => {
        if (err) {
          console.error("Failed to update password:", err);
          return res
            .status(500)
            .send({ success: false, message: "密码更新失败" });
        }
        res.send({ success: true, message: "密码已重置" });
      });
    } else {
      res.status(404).send({ success: false, message: "用户不存在" });
    }
  });
});

// 搜索药品信息
app.get("/api/search/drugs", (req, res) => {
  const { keyword } = req.query;
  const searchKeyword = `%${keyword}%`;
  const sqlSearchDrug =
    "SELECT * FROM drug_info WHERE name LIKE ? OR description LIKE ?";

  db.query(sqlSearchDrug, [searchKeyword, searchKeyword], (err, results) => {
    if (err) {
      console.error("Database query error:", err);
      return res
        .status(500)
        .send({ success: false, message: "数据库查询错误" });
    }
    res.send({ success: true, drugs: results });
  });
});

app.get("/api/search/nearby-stores", async (req, res) => {
  const { latitude, longitude } = req.query;
  if (!latitude || !longitude) {
    return res
      .status(400)
      .send({ success: false, message: "需要提供经纬度信息" });
  }
  const radius = 1000; // 搜索半径为1000米
  const url = `https://apis.map.qq.com/ws/place/v1/search?boundary=nearby(${latitude},${longitude},${radius})&keyword=药店&key=7DQBZ-FW53Q-NZX5T-2IBD6-WOSMZ-ORFZG`;

  try {
    const response = await axios.get(url);
    if (response.data.status === 0) {
      res.send({
        success: true,
        stores: response.data.data.map((store) => ({
          id: store.id,
          title: store.title,
          location: store.location,
        })),
      });
    } else {
      res.send({
        success: false,
        message: "地图服务请求失败",
        detail: response.data.message,
      });
    }
  } catch (error) {
    res
      .status(500)
      .send({ success: false, message: "服务器错误", error: error.message });
  }
});

//加载药单
app.get("/api/medications", (req, res) => {
  const phone = req.query.phone;
  if (!phone) {
    return res
      .status(400)
      .send({ success: false, message: "Phone number is required." });
  }

  // 首先根据电话号码查询用户ID
  const findUserId = "SELECT id FROM users WHERE phone = ?";
  db.query(findUserId, [phone], (err, userResults) => {
    if (err) {
      console.error("Database query error:", err);
      return res
        .status(500)
        .send({ success: false, message: "Database query error" });
    }
    if (userResults.length === 0) {
      return res
        .status(404)
        .send({ success: false, message: "User not found" });
    }

    const userId = userResults[0].id;
    console.log(userId);
    // 查询用户的所有药单
    const sql = "SELECT * FROM medications WHERE user_id = ?";
    db.query(sql, [userId], (err, medsResults) => {
      if (err) {
        console.error("Failed to retrieve medications:", err);
        return res
          .status(500)
          .send({ success: false, message: "Failed to retrieve medications" });
      }
      res.send({ success: true, medications: medsResults });
    });
  });
});

// 读取药物信息API
app.get("/api/drug-info", (req, res) => {
  const sql = "SELECT id, name, dosage, frequency_per_day FROM drug_info";
  db.query(sql, (err, results) => {
    if (err) {
      console.error("Failed to retrieve drug information:", err);
      return res.status(500).send({
        success: false,
        message: "Failed to retrieve drug information",
      });
    }
    res.send({ success: true, drugInfos: results });
  });
});

// PUT /api/medications/:id - 更新指定的药单
app.put("/api/medications/:id", (req, res) => {
  const {
    name,
    dosage,
    frequency,
    start_date,
    end_date,
    notes,
    taken_today,
    next_dose_time,
  } = req.body;
  const medicationId = req.params.id;

  if (!medicationId) {
    return res
      .status(400)
      .send({ success: false, message: "Medication ID is required." });
  }

  const sql = `
    UPDATE medications
    SET name = ?, dosage = ?, frequency = ?, start_date = ?, end_date = ?, notes = ?, taken_today = ?, next_dose_time = ?
    WHERE id = ?`;

  db.query(
    sql,
    [
      name,
      dosage,
      frequency,
      start_date,
      end_date,
      notes,
      taken_today,
      next_dose_time, // Updated next dose date
      medicationId,
    ],
    (err, result) => {
      if (err) {
        console.error("Failed to update medication:", err);
        return res
          .status(500)
          .send({ success: false, message: "Failed to update medication" });
      }
      if (result.affectedRows === 0) {
        return res
          .status(404)
          .send({ success: false, message: "Medication not found" });
      }
      res.send({ success: true, message: "Medication updated successfully" });
    }
  );
});

//减少每天的剂量
app.put("/api/meAbs/:id", (req, res) => {
  const medicationId = req.params.id;
  const { dosage, type } = req.body;
  const sql = `update medications set taken_today = taken_today ${
    type == 1 ? "+" : "-"
  } ? where id=?`;
  db.query(sql, [dosage, medicationId], (err, result) => {
    if (err) {
      console.error("Failed to update medication:", err);
      return res
        .status(500)
        .send({ success: false, message: "Failed to update medication" });
    }
    if (result.affectedRows === 0) {
      return res
        .status(404)
        .send({ success: false, message: "Medication not found" });
    }
    res.send({ success: true, message: "Medication updated successfully" });
  });
});

// DELETE /api/medications/:id - 删除指定的药单
app.delete("/api/medications/:id", (req, res) => {
  const medicationId = req.params.id;

  if (!medicationId) {
    return res
      .status(400)
      .send({ success: false, message: "Medication ID is required." });
  }

  const sql = "DELETE FROM medications WHERE id = ?";

  db.query(sql, [medicationId], (err, result) => {
    if (err) {
      console.error("Failed to delete medication:", err);
      return res
        .status(500)
        .send({ success: false, message: "Failed to delete medication" });
    }
    if (result.affectedRows === 0) {
      return res
        .status(404)
        .send({ success: false, message: "Medication not found" });
    }
    res.send({ success: true, message: "Medication deleted successfully" });
  });
});

// POST /api/medications - 创建新的药单
app.post("/api/medications", (req, res) => {
  const {
    phone,
    name,
    dosage,
    frequency,
    start_date,
    end_date,
    notes,
    taken_today,
    next_dose_time,
  } = req.body;

  if (!phone || !name) {
    return res
      .status(400)
      .send({ success: false, message: "Phone and Name are required." });
  }

  // 先根据电话号码查询用户ID
  const findUserId = "SELECT id FROM users WHERE phone = ?";
  db.query(findUserId, [phone], (err, userResults) => {
    if (err) {
      console.error("Database query error:", err);
      return res
        .status(500)
        .send({ success: false, message: "Database query error" });
    }
    if (userResults.length === 0) {
      return res
        .status(404)
        .send({ success: false, message: "User not found" });
    }

    const userId = userResults[0].id; // 获取用户ID
    // 查询drug_info表获取默认值
    const drugInfoSql =
      "SELECT dosage, frequency_per_day, usage_method FROM drug_info WHERE name = ?";
    db.query(drugInfoSql, [name], (err, drugInfoResults) => {
      if (err) {
        console.error("Failed to retrieve drug information:", err);
        return res.status(500).send({
          success: false,
          message: "Failed to retrieve drug information",
        });
      }
      if (drugInfoResults.length === 0) {
        return res
          .status(404)
          .send({ success: false, message: "Drug not found" });
      }

      // 使用提供的值或药品信息表中的默认值
      const defaultDosage = drugInfoResults[0].dosage;
      const defaultFrequency = drugInfoResults[0].frequency_per_day;
      const defaultNotes = drugInfoResults[0].usage_method;

      const finalDosage = dosage || defaultDosage;
      const finalFrequency = frequency || defaultFrequency;
      const finalNotes = notes || defaultNotes;
      const nextDoseDay = next_dose_time;

      // 插入新的药单记录
      const sql =
        "INSERT INTO medications (user_id, name, dosage, frequency, start_date, end_date, notes, taken_today, next_dose_time) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
      db.query(
        sql,
        [
          userId,
          name,
          finalDosage,
          finalFrequency,
          start_date,
          end_date,
          finalNotes,
          taken_today,
          nextDoseDay,
        ],
        (err, result) => {
          if (err) {
            console.error("Failed to create a new medication:", err);
            return res.status(500).send({
              success: false,
              message: "Failed to create a new medication",
            });
          }
          res.send({
            success: true,
            message: "Medication and reminder created successfully",
          });
        }
      );
    });
  });
});

function calculateNextDoseDay(frequency, taken_today, today, end_date) {
  let nextDoseDay = new Date(today);
  if (frequency - taken_today <= 0) {
    nextDoseDay.setDate(nextDoseDay.getDate() + 1); // Move to next day
  }

  // Adjust for end_date if necessary
  if (end_date && nextDoseDay > new Date(end_date)) {
    nextDoseDay = new Date(end_date);
  }

  // Format date as YYYY-MM-DD
  return `${nextDoseDay.getFullYear()}-${(nextDoseDay.getMonth() + 1)
    .toString()
    .padStart(2, "0")}-${nextDoseDay.getDate().toString().padStart(2, "0")}`;
}

//查询开始结束日期的药品
app.get("/api/medications/date", (req, res) => {
  const phone = req.query.phone; // 从请求中获取电话号码
  const date = req.query.date;
  if (!phone) {
    return res
      .status(400)
      .send({ success: false, message: "Phone number is required." });
  }

  // 首先根据电话号码查询用户ID
  const findUserId = "SELECT id,times FROM users WHERE phone = ?";
  db.query(findUserId, [phone], (err, userResults) => {
    if (err) {
      console.error("Database query error:", err);
      return res
        .status(500)
        .send({ success: false, message: "Database query error" });
    }
    if (userResults.length === 0) {
      return res
        .status(404)
        .send({ success: false, message: "User not found" });
    }

    const userId = userResults[0].id;

    const sql =
      "SELECT id, name, dosage, frequency, notes, taken_today, next_dose_time FROM medications WHERE user_id = ? AND start_date <= ? AND end_date >= ?";

    db.query(sql, [userId, date, date], (err, medsResults) => {
      if (err) {
        console.error("Failed to retrieve medications:", err);
        return res
          .status(500)
          .send({ success: false, message: "Failed to retrieve medications" });
      }
      res.send({ success: true, medications: medsResults });
    });
  });
});

// 获取某天药品API
app.get("/api/medications/today", (req, res) => {
  const phone = req.query.phone; // 从请求中获取电话号码
  const date = req.query.date;

  if (!phone) {
    return res
      .status(400)
      .send({ success: false, message: "Phone number is required." });
  }

  // 首先根据电话号码查询用户ID
  const findUserId = "SELECT id,times FROM users WHERE phone = ?";
  db.query(findUserId, [phone], (err, userResults) => {
    if (err) {
      console.error("Database query error:", err);
      return res
        .status(500)
        .send({ success: false, message: "Database query error" });
    }
    if (userResults.length === 0) {
      return res
        .status(404)
        .send({ success: false, message: "User not found" });
    }

    const userId = userResults[0].id;
    const times = JSON.parse(userResults[0].times);

    const sql =
      "SELECT id, name, dosage, frequency, notes, taken_today, next_dose_time FROM medications WHERE user_id = ? AND start_date <= ? AND end_date >= ?";

    db.query(sql, [userId, date, date], (err, medsResults) => {
      if (err) {
        console.error("Failed to retrieve medications:", err);
        return res
          .status(500)
          .send({ success: false, message: "Failed to retrieve medications" });
      }
      let list = [];
      for (let index = 0; index < times.length; index++) {
        const filed = times[index];
        let obj = {
          ids: [],
          names: [],
          dosage: [],
          taken_today: [],
        };
        medsResults.forEach((item) => {
          let doseTime = JSON.parse(item.next_dose_time);
          doseTime.forEach((itt) => {
            if (itt == filed) {
              obj.ids.push(item.id);
              obj.names.push(item.name);
              obj.dosage.push(parseInt(item.dosage));
              obj.taken_today.push(parseInt(item.taken_today));
            }
          });
        });
        list.push(obj);
      }
      res.send({ success: true, medications: list });
    });
  });
});

// 获取用户三餐时间API
app.get("/api/user-meal-times", (req, res) => {
  const phone = req.query.phone; // 从查询参数中获取电话号码

  if (!phone) {
    return res
      .status(400)
      .send({ success: false, message: "Phone number is required." });
  }

  const sql = "SELECT times FROM users WHERE phone = ?";

  db.query(sql, [phone], (err, results) => {
    if (err) {
      console.error("Database query error:", err);
      return res
        .status(500)
        .send({ success: false, message: "Database query error" });
    }

    if (results.length === 0) {
      return res
        .status(404)
        .send({ success: false, message: "User not found" });
    }

    // 假设我们总是找到恰好一个用户记录
    const userMealTimes = JSON.parse(results[0].times);
    res.send({ success: true, userMealTimes });
  });
});

// POST /api/medications/update-next-dose - 检查并更新next_dose_date和重置taken_today
app.post("/api/medications/update-next-dose", (req, res) => {
  const { phone } = req.body;
  const today = new Date();
  const dateString = `${today.getFullYear()}-${(today.getMonth() + 1)
    .toString()
    .padStart(2, "0")}-${today.getDate().toString().padStart(2, "0")}`;

  // 查询用户ID
  const userIdQuery = "SELECT id FROM users WHERE phone = ?";
  db.query(userIdQuery, [phone], (err, userResults) => {
    if (err) {
      console.error("Database query error:", err);
      return res
        .status(500)
        .send({ success: false, message: "Database query error" });
    }
    if (userResults.length === 0) {
      return res
        .status(404)
        .send({ success: false, message: "User not found" });
    }
    const userId = userResults[0].id;

    // 先查询是否需要更新
    const checkUpdateSql =
      "SELECT id FROM medications WHERE user_id = ? AND next_dose_date < ? AND next_dose_date < end_date";
    db.query(checkUpdateSql, [userId, dateString], (err, medsToUpdate) => {
      if (err) {
        console.error("Failed to check medications:", err);
        return res
          .status(500)
          .send({ success: false, message: "Failed to check medications" });
      }

      if (medsToUpdate.length > 0) {
        // 执行更新
        const updateSql = `
          UPDATE medications
          SET next_dose_date = DATE_ADD(next_dose_date, INTERVAL 1 DAY),
              taken_today = 0
          WHERE id IN (?)`;

        const medsIds = medsToUpdate.map((med) => med.id);
        db.query(updateSql, [medsIds], (err, result) => {
          if (err) {
            console.error("Failed to update next_dose_date:", err);
            return res.status(500).send({
              success: false,
              message: "Failed to update next_dose_date",
            });
          }
          res.send({
            success: true,
            message: "Next dose dates and taken_today updated successfully",
          });
        });
      } else {
        res.send({ success: true, message: "No medications need updating" });
      }
    });
  });
});

// 监听端口
const port = 3000;
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
