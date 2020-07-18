package com.onwardpath.wem.service;

import java.sql.PreparedStatement;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;

import com.onwardpath.wem.entity.Content;
import com.onwardpath.wem.model.ExperienceContentDTO;
import com.onwardpath.wem.model.ExperienceContentDTOMapper;
import com.onwardpath.wem.model.ExperienceEditContentDTO;
import com.onwardpath.wem.projections.EditMapper;

@Service
public class ExperienceEditServiceImpl implements ExperienceEdit {
	
	@Autowired
	private NamedParameterJdbcTemplate jdbcTemplate;
	



	
	  @Override public List<ExperienceEditContentDTO> experienceContent(String id)
	  {
	  
	  StringBuffer sb = new StringBuffer(); sb.append("select datatable.id")
	  .append(" id,") .append("datatable.url").append(" content,")
	  .append("''  segmentname, exp.name experience_name")
	  .append(" from config datatable,experience exp")
	  .append(" where datatable.experience_id = exp.id and exp.id='"+id+"'")
	  .append(" union all") .append(" select datatable.segment_id").append(" id,")
	  .append("datatable.content").append(" content,")
	  .append("seg.name  segmentname, exp.name experience_name")
	  .append(" from content datatable ,experience exp,segment seg")
	  .append(" where datatable.experience_id = exp.id and seg.id=datatable.segment_id and exp.id='"+id+"'");
	  //List<Content> returnlist = new ArrayList<Content>();
	  
	   
	  List<ExperienceEditContentDTO> expCountQueryDTO = jdbcTemplate.query(sb.toString(),new EditMapper());
	  
	  
	  System.out.println("List Size is:"+ expCountQueryDTO.size()); return
	  expCountQueryDTO;
	  
	  }
	 }
