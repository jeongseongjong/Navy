package com.biz.navy.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.biz.navy.domain.PageVO;
import com.biz.navy.domain.UserDetailsVO;

public interface UserDao {

	public int insert(UserDetailsVO userVO);

	public UserDetailsVO findByUserName(String username);

	public int update(UserDetailsVO userVO);
	
	public int update_auth(UserDetailsVO userVO);
	

	public List<UserDetailsVO> selectAll();
	
	public List<UserDetailsVO> selectAllPaging(PageVO pageVO);

	@Select("SELECT count(*) FROM tbl_users")
	public long countAll();

	public List<UserDetailsVO> findBySearchNameAndPaging(@Param("searchList") List<String> searchList, @Param("pageVO") PageVO pageVO);

	public long countSearch(@Param("searchList")List<String> searchList);
	

}
