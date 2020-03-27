package com.spring.project;

public interface SeatDAO {

	SeatDTO selectOne(SeatDTO seatDto);
	void insert(SeatDTO seatDto);
	void update(SeatDTO seatDto);
}
