package com.dihaozhe.rtmsbackend.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.dihaozhe.enumeration.StateCode;
import com.dihaozhe.response.CommonResponse;
import com.dihaozhe.response.ResponseUtils;
import com.dihaozhe.rtmsbackend.mapper.AccountMapper;
import com.dihaozhe.rtmsbackend.mapper.OrderMapper;
import com.dihaozhe.rtmsbackend.pojo.entity.Account;
import com.dihaozhe.rtmsbackend.pojo.entity.Order;
import com.dihaozhe.rtmsbackend.pojo.entity.Store;
import com.dihaozhe.rtmsbackend.pojo.vo.RiderOrderNumberVO;
import com.dihaozhe.rtmsbackend.service.OrderService;
import com.dihaozhe.rtmsbackend.service.StoreService;
import com.dihaozhe.rtmsbackend.util.BaiduMapUtil;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import static com.dihaozhe.constant.OrderProgressConstant.*;
import static com.dihaozhe.constant.StatusConstant.*;
import static com.dihaozhe.util.Code.generateCode;


@Slf4j
@Service
public class OrderServiceImpl implements OrderService {

    @Resource
    OrderMapper orderMapper;

    @Resource
    AccountMapper accountMapper;
    
    @Resource
    StoreService storeService;

    @Override
    public CommonResponse createOrder(Order order, HttpServletRequest request) {
        // 1. 校验数据是否合法
        String accountId = String.valueOf(order.getAccountId());
        String storeId = String.valueOf(order.getStoreId());
        String code = generateCode();
        String note = order.getNote();
        String expectedTime = order.getExpectedTime();
        String address = order.getAddress();
        String packagePrice = String.valueOf(order.getPackagePrice());
        String deliveryPrice = String.valueOf(order.getDeliveryPrice());
        String totalPrice = String.valueOf(order.getTotalPrice());
        String payment = order.getPayment();

        // 账号id为空
        if (accountId.isEmpty()) {
            return ResponseUtils.error(StateCode.ACCOUNT_ID_EMPTY);
        }

        // 店铺id为空
        if (storeId.isEmpty()) {
            return ResponseUtils.error(StateCode.STORE_ID_EMPTY);
        }

        // 备注为空
        if (note.isEmpty()) {
            order.setNote("无备注");
        }
        
        // 2. 检查取餐点和餐厅之间的距离是否超过10000米
        try {
            // 获取餐厅信息
            CommonResponse storeResponse = storeService.selectStoreByStoreId(order.getStoreId(), request);
            Store store = (Store) storeResponse.getData();
            
            // 获取餐厅地址和取餐点地址
            String storeAddress = store.getAddress();
            String pickupAddress = order.getAddress();
            
            // 假设城市为漳州，可以根据实际情况调整或从地址中解析
            String city = "漳州";
            
            // 输出地址信息日志
            log.info("计算距离 - 餐厅地址: {}, 取餐点地址: {}, 城市: {}", storeAddress, pickupAddress, city);
            
            // 计算两个地址之间的距离
            long distance = BaiduMapUtil.calculateDistance(storeAddress, pickupAddress, city);
            
            // 输出距离计算结果日志
            log.info("距离计算结果: {} 米", distance);
            
            // 检查距离是否超过10000米
            if (distance > 0 && distance <= 10000) {
                // 距离符合要求，继续创建订单
                // 将表单信息传入实体类
                order.setCode(code);
                order.setProgress(PENDING_PAYMENT);
                order.setStatus(NORMAL);
                orderMapper.insert(order);
                return ResponseUtils.success(order.getId());
            } else if (distance == -1) {
                // 距离计算失败
                return ResponseUtils.error(400, "地址解析或距离计算失败，请检查地址信息是否正确");
            } else {
                // 距离超过10000米
                return ResponseUtils.error(400, "取餐点与餐厅距离超过10000米，无法创建订单");
            }
        } catch (Exception e) {
            log.error("距离检查异常: {}", e.getMessage(), e);
            return ResponseUtils.error(400, "距离检查异常，请稍后重试");
        }
    }

    @Override
    public CommonResponse deleteOrder(Long id, HttpServletRequest request) {
        return null;
    }

    @Override
    public CommonResponse updateOrder(Order order, HttpServletRequest request) {
        return null;
    }

    @Override
    public CommonResponse selectOrderById(Long id, HttpServletRequest request) {
        // 将数据库订单表内容取出
        QueryWrapper<Order> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("id",id);
        Order order = orderMapper.selectOne(queryWrapper);
        return ResponseUtils.success(order);
    }

    @Override
    public CommonResponse selectOrdersByStoreId(Long storeId, HttpServletRequest request) {
        // 将数据库订单表内容取出
        QueryWrapper<Order> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("store_id",storeId);
        queryWrapper.ne("progress",CANCELED);
        queryWrapper.ne("progress",PENDING_PAYMENT);
        queryWrapper.ne("status",DELETED);
        List<Order> orders = orderMapper.selectList(queryWrapper);
        return ResponseUtils.success(orders);
    }

    @Override
    public CommonResponse selectOrdersByAccountId(Long accountId, HttpServletRequest request) {
        // 将数据库订单表内容取出
        QueryWrapper<Order> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("account_id",accountId);
        queryWrapper.ne("status",DELETED);
        List<Order> orders = orderMapper.selectList(queryWrapper);
        return ResponseUtils.success(orders);
    }

    @Override
    public CommonResponse selectPendingPaymentOrdersByAccountId(Long accountId, HttpServletRequest request) {
        // 将数据库订单表内容取出
        QueryWrapper<Order> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("account_id",accountId);
        queryWrapper.eq("progress",PENDING_PAYMENT);
        queryWrapper.ne("status",DELETED);
        List<Order> orders = orderMapper.selectList(queryWrapper);
        return ResponseUtils.success(orders);
    }

    @Override
    public CommonResponse selectDeliveringOrdersByAccountId(Long accountId, HttpServletRequest request) {
        // 将数据库订单表内容取出
        QueryWrapper<Order> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("account_id",accountId);
        queryWrapper.eq("progress",DELIVERING);
        queryWrapper.ne("status",DELETED);
        List<Order> orders = orderMapper.selectList(queryWrapper);
        return ResponseUtils.success(orders);
    }

    @Override
    public CommonResponse selectCompletedOrdersByAccountId(Long accountId, HttpServletRequest request) {
        // 将数据库订单表内容取出
        QueryWrapper<Order> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("account_id",accountId);
        queryWrapper.eq("progress",COMPLETED);
        queryWrapper.ne("status",DELETED);
        List<Order> orders = orderMapper.selectList(queryWrapper);
        return ResponseUtils.success(orders);
    }

    @Override
    public CommonResponse cancelOrderById(Long id, HttpServletRequest request) {
        UpdateWrapper<Order> updateWrapper = new UpdateWrapper<>();
        updateWrapper.set("progress", CANCELED);  // 设置要更新的字段及值
        updateWrapper.eq("id", id);  // 设置更新条件，这里假设使用 ID 作为更新条件
        orderMapper.update(null, updateWrapper);
        return ResponseUtils.success();
    }

    @Override
    public CommonResponse cancelOrderByIdAndMoneyBack(Long id, HttpServletRequest request) {
        // 查询订单总价值
        QueryWrapper<Order> orderQueryWrapper = new QueryWrapper<>();
        orderQueryWrapper.eq("id", id);
        Order order = orderMapper.selectOne(orderQueryWrapper);
        Long totalPrice = order.getTotalPrice();
        Long accountId = order.getAccountId();

        // 查询账号余额
        QueryWrapper<Account> accountQueryWrapper = new QueryWrapper<>();
        accountQueryWrapper.eq("id", accountId);
        Account account = accountMapper.selectOne(accountQueryWrapper);
        Long money = account.getMoney();
        money = money + totalPrice;

        // 更新订单状态
        UpdateWrapper<Order> orderUpdateWrapper = new UpdateWrapper<>();
        orderUpdateWrapper.set("progress", CANCELED);  // 设置要更新的字段及值
        orderUpdateWrapper.eq("id", id);  // 设置更新条件，这里假设使用 ID 作为更新条件
        orderMapper.update(null, orderUpdateWrapper);

        // 更新账号余额
        UpdateWrapper<Account> accountUpdateWrapper = new UpdateWrapper<>();
        accountUpdateWrapper.set("money", money);  // 设置要更新的字段及值
        accountUpdateWrapper.eq("id", accountId);  // 设置更新条件，这里假设使用 ID 作为更新条件
        accountMapper.update(null, accountUpdateWrapper);
        return ResponseUtils.success();
    }

    @Override
    public CommonResponse customerDeleteOrderById(Long id, HttpServletRequest request) {
        // 将数据库订单表内容取出
        QueryWrapper<Order> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("id",id);
        Order order = orderMapper.selectOne(queryWrapper);
        String status = order.getStatus();
        switch (status) {
            case "正常": {
                UpdateWrapper<Order> updateWrapper = new UpdateWrapper<>();
                updateWrapper.set("status", CUSTOMER_DELETED);  // 设置要更新的字段及值
                updateWrapper.eq("id", id);  // 设置更新条件，这里假设使用 ID 作为更新条件
                orderMapper.update(null, updateWrapper);
                break;
            }
            case "商家已删除": {
                UpdateWrapper<Order> updateWrapper = new UpdateWrapper<>();
                updateWrapper.set("status", CUSTOMER_STORE_DELETED);  // 设置要更新的字段及值
                updateWrapper.eq("id", id);  // 设置更新条件，这里假设使用 ID 作为更新条件
                orderMapper.update(null, updateWrapper);
                break;
            }
            case "骑手已删除": {
                UpdateWrapper<Order> updateWrapper = new UpdateWrapper<>();
                updateWrapper.set("status", CUSTOMER_RIDER_DELETED);  // 设置要更新的字段及值
                updateWrapper.eq("id", id);  // 设置更新条件，这里假设使用 ID 作为更新条件
                orderMapper.update(null, updateWrapper);
                break;
            }
            case "商家骑手已删除": {
                UpdateWrapper<Order> updateWrapper = new UpdateWrapper<>();
                updateWrapper.set("status", DELETED);  // 设置要更新的字段及值
                updateWrapper.eq("id", id);  // 设置更新条件，这里假设使用 ID 作为更新条件
                orderMapper.update(null, updateWrapper);
                break;
            }
        }
        return ResponseUtils.success();
    }

    @Override
    public CommonResponse customerPaymentOrderById(Long id, HttpServletRequest request) {
        // 将数据库订单表内容取出
        UpdateWrapper<Order> updateWrapper = new UpdateWrapper<>();
        updateWrapper.set("progress", PAID);  // 设置要更新的字段及值
        updateWrapper.eq("id", id);  // 设置更新条件，这里假设使用 ID 作为更新条件
        orderMapper.update(null, updateWrapper);
        return ResponseUtils.success();
    }

    @Override
    public CommonResponse storeAcceptOrderById(Long id, HttpServletRequest request) {
        // 将数据库订单表内容取出
        UpdateWrapper<Order> updateWrapper = new UpdateWrapper<>();
        updateWrapper.set("progress", ORDER_ACCEPTED);  // 设置要更新的字段及值
        updateWrapper.eq("id", id);  // 设置更新条件，这里假设使用 ID 作为更新条件
        orderMapper.update(null, updateWrapper);
        return ResponseUtils.success();
    }

    @Override
    public CommonResponse storeOutOrderById(Long id, HttpServletRequest request) {
        // 将数据库订单表内容取出
        UpdateWrapper<Order> updateWrapper = new UpdateWrapper<>();
        updateWrapper.set("progress", TO_BE_DELIVERED);  // 设置要更新的字段及值
        updateWrapper.eq("id", id);  // 设置更新条件，这里假设使用 ID 作为更新条件
        orderMapper.update(null, updateWrapper);
        return ResponseUtils.success();
    }


    @Override
    public CommonResponse riderAcceptOrderById(Long id, Long riderId, HttpServletRequest request) {
        // 将数据库订单表内容取出
        UpdateWrapper<Order> updateWrapper = new UpdateWrapper<>();
        updateWrapper.set("rider_id", riderId);  // 设置要更新的字段及值
        updateWrapper.set("progress", DELIVERING);  // 设置要更新的字段及值
        updateWrapper.eq("id", id);  // 设置更新条件，这里假设使用 ID 作为更新条件
        orderMapper.update(null, updateWrapper);
        return ResponseUtils.success();
    }

    @Override
    public CommonResponse riderDeliveredOrderById(Long id, HttpServletRequest request) {
        // 将数据库订单表内容取出
        UpdateWrapper<Order> updateWrapper = new UpdateWrapper<>();
        updateWrapper.set("progress", DELIVERED);  // 设置要更新的字段及值
        updateWrapper.eq("id", id);  // 设置更新条件，这里假设使用 ID 作为更新条件
        orderMapper.update(null, updateWrapper);
        return ResponseUtils.success();
    }

    @Override
    public CommonResponse customerCompletedOrderById(Long id, HttpServletRequest request) {
        // 将数据库订单表内容取出
        UpdateWrapper<Order> updateWrapper = new UpdateWrapper<>();
        updateWrapper.set("progress", COMPLETED);  // 设置要更新的字段及值
        updateWrapper.eq("id", id);  // 设置更新条件，这里假设使用 ID 作为更新条件
        orderMapper.update(null, updateWrapper);
        return ResponseUtils.success();
    }

    //查询待接订单
    @Override
    public CommonResponse selectToBeDeliveredOrders(HttpServletRequest request) {
        // 将数据库订单表内容取出
        QueryWrapper<Order> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("progress",TO_BE_DELIVERED);
        queryWrapper.ne("status",DELETED);
        List<Order> orders = orderMapper.selectList(queryWrapper);
        return ResponseUtils.success(orders);
    }

    @Override
    public CommonResponse selectOrdersByRiderIdAndProgress(Long riderId, String progress, HttpServletRequest request) {
        // 将数据库订单表内容取出
        QueryWrapper<Order> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("rider_id",riderId);
        queryWrapper.eq("progress",progress);
        queryWrapper.ne("status",DELETED);
        List<Order> orders = orderMapper.selectList(queryWrapper);
        return ResponseUtils.success(orders);
    }

    @Override
    public CommonResponse selectOrderCompleteNumberByRiderId(Long riderId, HttpServletRequest request) {
        // 获取当前时间
        Date today = new Date();

        // 获取今天的开始和结束时间
        Date startOfDay = getStartOfDay(today);
        Date endOfDay = getEndOfDay(today);

        // 创建查询条件包装器
        QueryWrapper<Order> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("rider_id", riderId);
        queryWrapper.eq("progress", COMPLETED);
        queryWrapper.between("update_time", startOfDay, endOfDay); // 过滤今天内更新的订单
        queryWrapper.ne("status", DELETED);

        // 选择订单
        List<Order> orders = orderMapper.selectList(queryWrapper);
        int dayNumber = orders.size();
        log.info(orders.toString());

        // 获取本月的开始日期和结束日期
        Date startOfMonth = getStartOfMonth(today);
        Date endOfMonth = getEndOfMonth(today);

        // 创建查询条件包装器
        QueryWrapper<Order> queryMonthWrapper = new QueryWrapper<>();
        queryMonthWrapper.eq("rider_id", riderId);
        queryMonthWrapper.eq("progress", COMPLETED);
        queryMonthWrapper.between("update_time", startOfMonth, endOfMonth); // 过滤本月内更新的订单
        queryMonthWrapper.ne("status", DELETED);

        // 选择订单
        List<Order> ordersMonth = orderMapper.selectList(queryMonthWrapper);
        int monthNumber = ordersMonth.size();
        log.info(ordersMonth.toString());

        RiderOrderNumberVO riderOrderNumberVO = new RiderOrderNumberVO(dayNumber, monthNumber);
        return ResponseUtils.success(riderOrderNumberVO);
    }

    @Override
    public CommonResponse selectCompletedOrders(HttpServletRequest request) {
        // 将数据库订单表内容取出
        QueryWrapper<Order> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("progress",COMPLETED);
        queryWrapper.ne("status",DELETED);
        List<Order> orders = orderMapper.selectList(queryWrapper);
        return ResponseUtils.success(orders);
    }

    // 获取今天的开始时间
    private Date getStartOfDay(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        return calendar.getTime();
    }

    // 获取今天的结束时间
    private Date getEndOfDay(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.set(Calendar.HOUR_OF_DAY, 23);
        calendar.set(Calendar.MINUTE, 59);
        calendar.set(Calendar.SECOND, 59);
        return calendar.getTime();
    }

    // 获取本月的开始日期
    private Date getStartOfMonth(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        return calendar.getTime();
    }

    // 获取本月的结束日期
    private Date getEndOfMonth(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
        calendar.set(Calendar.HOUR_OF_DAY, 23);
        calendar.set(Calendar.MINUTE, 59);
        calendar.set(Calendar.SECOND, 59);
        return calendar.getTime();
    }
}
