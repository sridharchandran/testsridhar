package com.onwardpath.wem.projections;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.onwardpath.wem.model.ExperienceEditContentDTO;
import com.onwardpath.wem.model.SchduleExpDTO;

public class SchudleMapper implements RowMapper<SchduleExpDTO> {

	@Override
	public SchduleExpDTO mapRow(ResultSet result, int rowNum) throws SQLException {
		// TODO Auto-generated method stub
		SchduleExpDTO sch = new SchduleExpDTO();
		sch.setStatus(result.getString("status"));
		sch.setStartDate(result.getString("schedule_start"));
		sch.setEndDate(result.getString("schedule_end"));
		sch.setTimeZonevalue(result.getString("timezone_id"));

		return sch;
	}

}
