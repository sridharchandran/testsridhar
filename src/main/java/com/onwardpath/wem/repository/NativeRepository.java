package com.onwardpath.wem.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Component;

import com.onwardpath.wem.model.NativeQueryDTO;
import com.onwardpath.wem.model.NativeQueryDTOMapper;

@Component
public class NativeRepository {
   
	@Autowired 
    private NamedParameterJdbcTemplate jdbcTemplate;
	
    public List<NativeQueryDTO> getResultSetforExpView(){        
        MapSqlParameterSource parameters = new MapSqlParameterSource();
        //parameters.addValue("customerId", id);
        String sql = "SELECT  * FROM  (select  experience.id as id, experience.name as experience,  experience.type as type,   experience.status as status,  GROUP_CONCAT(   distinctrow concat(segment.id ,':',segment.name) separator ',' ) as segmentname,  experience.create_time as create_time,  CONCAT(  user.firstname, ' ', user.lastname ) as name from  user, experience, segment, content where   experience.id = content.experience_id   and content.segment_id = segment.id   and user.org_id = 1  and experience.org_id = \"1\"  GROUP BY   experience.id union all\r\n" + 
        		"select  experience.id as id, experience.name as Experience,  experience.type as type,   experience.status as status,  GROUP_CONCAT(   distinctrow concat(segment.id ,':',segment.name) separator ',' ) as segmentname,  experience.create_time as create_time,  CONCAT(  user.firstname, ' ', user.lastname ) as name from  user, experience, segment, image where   experience.id = image.experience_id   and image.segment_id = segment.id   and user.org_id = 1  and experience.org_id = \"1\"  GROUP BY   experience.id union all\r\n" + 
        		"select  experience.id as id, experience.name as Experience,  experience.type as type,   experience.status as status,  GROUP_CONCAT(   distinctrow concat(segment.id ,':',segment.name) separator ',' ) as segmentname,  experience.create_time as create_time,  CONCAT(  user.firstname, ' ', user.lastname ) as name from  user, experience, segment, redirect where   experience.id = redirect.experience_id   and redirect.segment_id = segment.id   and user.org_id = 1  and experience.org_id = \"1\"  GROUP BY   experience.id union all\r\n" + 
        		" select  experience.id as id, experience.name as Experience,  experience.type as type,   experience.status as status,  GROUP_CONCAT(   distinctrow concat(segment.id ,':',segment.name) separator ',' ) as segmentname,  experience.create_time as create_time,  CONCAT(  user.firstname, ' ', user.lastname ) as name from  user, experience, segment, block where   experience.id = block.experience_id   and block.segment_id = segment.id   and user.org_id = 1  and experience.org_id = \"1\"  GROUP BY   experience.id  union all\r\n" + 
        		" select  experience.id as id, experience.name as Experience,  experience.type as type,   experience.status as status,  GROUP_CONCAT(   distinctrow concat(segment.id ,':',segment.name) separator ',' ) as segmentname,  experience.create_time as create_time,  CONCAT(  user.firstname, ' ', user.lastname ) as name from  user, experience, segment, style where   experience.id = style.experience_id   and style.segment_id = segment.id   and user.org_id = 1  and experience.org_id = \"1\"  GROUP BY   experience.id )experience\r\n" + 
        		"GROUP BY experience.id ORDER BY experience.create_time 	DESC limit 0, 10";
        List<NativeQueryDTO> nativeQueryDTO = jdbcTemplate.query(sql, new NativeQueryDTOMapper());
        return nativeQueryDTO;  
    }
}