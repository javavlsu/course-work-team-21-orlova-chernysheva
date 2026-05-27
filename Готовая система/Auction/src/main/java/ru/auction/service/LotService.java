package ru.auction.service;

import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.auction.DTO.LotDTO;
import ru.auction.model.Bid;
import ru.auction.model.Lot;
import ru.auction.repository.BidRepository;
import ru.auction.repository.LotRepository;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
@Service
public class LotService {
    @Autowired
    private LotRepository lotRepository;
    @Autowired
    private BidRepository bidRepository;

    @Transactional
    public List<LotDTO> getLotsBySellerId(int sellerId) {
        return lotRepository.findBySellerId(sellerId).stream()
                .map(lot -> {
                    // Явно инициализируем Auction
                    Hibernate.initialize(lot.getAuction());

                    LotDTO dto = new LotDTO();
                    dto.setId(lot.getId());
                    dto.setTitle(lot.getTitle());
                    dto.setStatus(lot.getStatus());
                    dto.setStartPrice(lot.getStartPrice());

                    if (lot.getAuction() != null && lot.getAuction().getEndTime() != null) {
                        dto.setEndTimeFormatted(lot.getAuction().getEndTime());
                    }
                    return dto;
                })
                .collect(Collectors.toList());
    }

    @Transactional
    public Optional<LotDTO> getLotWithWinnerInfo(int lotId) {
        Optional<Lot> lotOptional = lotRepository.findById(lotId);

        if (lotOptional.isPresent()) {
            Lot lot = lotOptional.get();
            Hibernate.initialize(lot.getAuction());

            Optional<Bid> winnerBidOptional = bidRepository.findTopBidByLotId(lotId);

            LotDTO dto = new LotDTO();
            dto.setId(lot.getId());
            dto.setTitle(lot.getTitle());
            dto.setAuthor(lot.getAuthor());
            dto.setDescription(lot.getDescription());
            dto.setStartPrice(lot.getStartPrice());
            dto.setStatus(lot.getStatus());

            if (lot.getAuction() != null && lot.getAuction().getEndTime() != null) {
                dto.setEndTimeFormatted(lot.getAuction().getEndTime());
            }

            if (winnerBidOptional.isPresent()) {
                Bid winnerBid = winnerBidOptional.get();
                dto.setCurrentPrice(winnerBid.getBidAmount());
                dto.setWinnerEmail(winnerBid.getUser().getEmail());
                dto.setWinnerBidAmount(winnerBid.getBidAmount());
            } else {
                dto.setCurrentPrice(null);
                dto.setWinnerEmail(null);
                dto.setWinnerBidAmount(0.0);
            }

            return Optional.of(dto);
        }
        return Optional.empty();
    }
    @Transactional
    public Optional<Lot> getLotById(int lotId) {
        Optional<Lot> lotOptional = lotRepository.findById(lotId);

        if (lotOptional.isPresent()) {
            Lot lot = lotOptional.get();
            // Инициализируем связанные сущности, чтобы избежать LazyInitializationException
            Hibernate.initialize(lot.getUser());
            Hibernate.initialize(lot.getAuction());
        }

        return lotOptional;
    }

}
