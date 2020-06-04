package com.biz.navy.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.biz.navy.domain.CsCommentVO;
import com.biz.navy.domain.CsVO;
import com.biz.navy.domain.PageVO;

public interface CsDao {

	@Select("SELECT * FROM tbl_cs")
	public List<CsVO> selectAll();
	
	@Select("SELECT * FROM tbl_cs WHERE cs_id = #{cs_id}")
	public CsVO findById(long cs_id);
	
	@Insert("INSERT INTO tbl_cs(cs_id, cs_username, cs_title, cs_text, cs_date, cs_time, cs_file) "
			+ " VALUES(SEQ_CS.NEXTVAL, "
			+ "#{cs_username,jdbcType=VARCHAR}, "
			+ "#{cs_title,jdbcType=VARCHAR}, "
			+ "#{cs_text,jdbcType=VARCHAR}, "
			+ "#{cs_date,jdbcType=VARCHAR}, "
			+ "#{cs_time,jdbcType=VARCHAR}, "
			+ "#{cs_file,jdbcType=VARCHAR} ) ")
	public int insert(CsVO csVO);
	
	@Update("UPDATE tbl_cs SET "
			+ "    cs_title = #{cs_title,jdbcType=VARCHAR} , "
			+ "    cs_text = #{cs_text,jdbcType=VARCHAR}, "
			+ "    cs_date = #{cs_date,jdbcType=VARCHAR}, "  
			+ "    cs_time = #{cs_time,jdbcType=VARCHAR}, "  
			+ "    cs_file = #{cs_file,jdbcType=VARCHAR}, "
			+ "    cs_count = #{cs_count,jdbcType=VARCHAR} "
			
			+ " WHERE cs_id = #{cs_id} "
			)
	public int update(CsVO csVO);
	
	@Delete("DELETE FROM tbl_cs WHERE cs_id = #{cs_id}")
	public int delete(long cs_id);

	public List<CsVO> findBySearchNameAndPaging(@Param("searchList")List<String> searchList, @Param("pageVO")PageVO pageVO);

	public List<CsVO> selectAllPaging(PageVO pageVO);

	public long countAll();

	public long countSearch(@Param("searchList") List<String> searchList);

	public int insertComment(CsCommentVO csCommentVO);

//	@Select("SELECT * FROM tbl_cs_comment WHERE cs_c_b_id = #{cs_id} ORDER BY cs_c_id ")
	public List<CsCommentVO> findCommentByBId(long cs_id);

	@Delete("DELETE FROM tbl_cs_comment WHERE cs_c_id = #{cid}")
	public int deleteComment(long cid);
	
}
