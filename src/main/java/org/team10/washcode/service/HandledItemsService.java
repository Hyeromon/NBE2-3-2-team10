package org.team10.washcode.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.team10.washcode.entity.HandledItems;
import org.team10.washcode.repository.db.HandledItemsRepository;

import java.util.List;

@Service
public class HandledItemsService {
    @Autowired
    private HandledItemsRepository handledItemsRepository;

    public HandledItems getHandledItemById(Long id) {
        // itemId로 데이터베이스에서 아이템을 조회
        return handledItemsRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("아이템을 찾을 수 없습니다. ID: " + id));
    }


    public List<HandledItems> getAllHandledItems(Long laundryShopId) {
        try {
            return handledItemsRepository.findByLaundryshopId(laundryShopId);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("HandledItems 조회 중 오류 발생", e);
        }
    }

}
