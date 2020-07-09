package com.onwardpath.wem.model;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class SegmentGetResultDTOMapper implements RowMapper<SegmentGetResultDTO> {

	@Override
	public SegmentGetResultDTO mapRow(ResultSet rs, int rowNum) throws SQLException {

		SegmentGetResultDTO dto = new SegmentGetResultDTO();
		
			dto.setSegmentid(rs.getInt("segmentid"));
			dto.setSegmentname(rs.getString("segmentname"));
			dto.setSegrule(rs.getString("segrule"));
			dto.setName(rs.getString("name"));
		
		return dto;
	}

}
