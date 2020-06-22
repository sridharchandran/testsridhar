package com.onwardpath.wem.model;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class NativeQueryDTOMapper implements RowMapper<NativeQueryDTO>{

	@Override
	public NativeQueryDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
		 NativeQueryDTO dto = new NativeQueryDTO();
		 dto.setId(rs.getInt("id"));
		 dto.setExperience(rs.getString("experience"));
		 dto.setType(rs.getString("type"));
		 dto.setStatus(rs.getString("status"));
		 dto.setSegmentname(rs.getString("segmentname"));
		 dto.setCreate_time(rs.getString("create_time"));
		 dto.setName(rs.getString("name"));
	
		 return dto;
	}
	

}
