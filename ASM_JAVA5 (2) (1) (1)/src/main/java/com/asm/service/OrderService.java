package com.asm.service;


import com.asm.dto.OrderStatusCount;
import com.asm.dto.OrderSummary;
import com.asm.dto.ProductRevenueDTO;
import com.asm.model.OrderDetail;
import com.asm.repository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import jakarta.persistence.Tuple;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Service
public class OrderService {

    @Autowired
    private OrderRepository orderRepository;

    public List<OrderStatusCount> getOrderCountByStatus() {
        return orderRepository.countOrdersByStatus();
    }

    private OrderSummary convertTupleToOrderSummary(Tuple tuple) {
        int orderCount = ((Number) tuple.get("orderCount")).intValue();
        float totalRevenue = ((Number) tuple.get("totalRevenue")).floatValue();
        return new OrderSummary(orderCount, totalRevenue);
    }
    
    
    
    public OrderSummary getTotalRevenueSummaryByDate(Date date) {
        List<Tuple> tuples = orderRepository.getSummaryByDate(date);
        if (!tuples.isEmpty()) {
            return convertTupleToOrderSummary(tuples.get(0));
        }
        return new OrderSummary(0, 0);
    }
    
    public OrderSummary getTotalRevenueSummaryByYesterday() {
        
        List<Tuple> summaryYesterday = orderRepository.getSummaryByYesterday();

        
        if (!summaryYesterday.isEmpty()) {
            long orderCountYesterday = ((Number) summaryYesterday.get(0).get("orderCount")).longValue();
            float totalRevenueYesterday = ((Number) summaryYesterday.get(0).get("totalRevenue")).floatValue();
            return new OrderSummary((int) orderCountYesterday, totalRevenueYesterday);

          
        }
        
        return new OrderSummary(0, 0);
    }
        
    


    public OrderSummary getTotalRevenueSummaryByMonth(Integer month) {
        List<Tuple> tuples = orderRepository.getSummaryByMonth(month);
        if (!tuples.isEmpty()) {
            return convertTupleToOrderSummary(tuples.get(0));
        }
        return new OrderSummary(0, 0);
    }

    public OrderSummary getTotalRevenueSummaryByYear(Integer year) {
        List<Tuple> tuples = orderRepository.getSummaryByYear(year);
        if (!tuples.isEmpty()) {
            return convertTupleToOrderSummary(tuples.get(0));
        }
        return new OrderSummary(0, 0);
    }
    
    public List<ProductRevenueDTO> getTopProductRevenues() {
        
        Pageable pageable = PageRequest.of(0, 4);
        return orderRepository.getTopProductRevenues(pageable);
    }
    
    
    
}
