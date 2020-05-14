package com.biz.navy.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.biz.navy.dao.AuthoritiesDao;
import com.biz.navy.dao.UserDao;
import com.biz.navy.domain.AuthorityVO;
import com.biz.navy.domain.UserDetailsVO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Slf4j
@Service("userService")
public class UserService implements UserDetailsService{

	private final PasswordEncoder passwordEncoder;
	
	private final UserDao userDao;
	private final AuthoritiesDao authDao;
	
	
	public int insert(String username, String password) {
		String encPassword = passwordEncoder.encode(password);
		UserDetailsVO userVO = UserDetailsVO.builder()
								.username(username)
								.password(encPassword)
								.enabled(true)
								.build();
		int ret = userDao.insert(userVO);
		
		List<AuthorityVO> authList = new ArrayList();
		authList.add(AuthorityVO.builder()
						.username(userVO.getUsername())
						.authority("ROLE_USER").build()
				);
		
		
		authList.add(AuthorityVO.builder()
				.username(userVO.getUsername())
				.authority("USER").build());
		
		authDao.insert(authList);
	
		return ret;
		
	}


	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// TODO Auto-generated method stub
		
		UserDetailsVO userVO = userDao.findByUserName(username);
		if(userVO == null) {
			throw new UsernameNotFoundException("User Name이 없습니다");
		}
		userVO.setEnabled(true);
		
		userVO.setAccountNonExpired(true);
		userVO.setAccountNonLocked(true);
		userVO.setCredentialsNonExpired(true);
		
		userVO.setAuthorities(this.getAuthorities(username));
		
		
		return userVO;
	}
	
	private Collection<GrantedAuthority> getAuthorities(String username) {
		List<AuthorityVO> authList = authDao.findByUserName(username);
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		
		for(AuthorityVO vo : authList) {
			SimpleGrantedAuthority sAuth = new SimpleGrantedAuthority(vo.getAuthority());
			authorities.add(sAuth);
		}
		
		return authorities;
	}


	public boolean check_password(String password) {
		// TODO Auto-generated method stub
		UserDetailsVO userVO = (UserDetailsVO) SecurityContextHolder
							.getContext()
							.getAuthentication()
							.getPrincipal();
		return passwordEncoder.matches(password.trim(), userVO.getPassword());
	}

	/**
	 *  유저리스트 조회
	 * @return
	 * @author bjmin17
	 */
	public List<UserDetailsVO> selectAll() {
		return userDao.selectAll();
	}

	/**
	 * 유저 디테일 조회
	 * @param username
	 * @return
	 * @author bjmin17
	 */
	public UserDetailsVO findByUserName(String username) {

		return userDao.findByUserName(username);
	}

	/**
	 * 관리자가 유저 정보 수정(권한 수정)
	 * @param userVO
	 * @param authList
	 * @return
	 * 
	 * @author bjmin17
	 */
	public int update(UserDetailsVO userVO, String[] authList) {

		int ret = userDao.update(userVO);
		
		// DB Update를 성공하면
		// 로그인된 session 정보를 update 수행
		if(ret > 0) {
			List<AuthorityVO> authCollection = new ArrayList<>();
			
			for(String auth : authList) {
				// auth가 빈칸인 경우가 생기지 않게 검사
				if(!auth.isEmpty()) {
					AuthorityVO authVO = AuthorityVO.builder()
									.username(userVO.getUsername())
									.authority(auth).build();
				}
			}
			
//			authDao.delete(userVO.getUsername());
			authDao.insert(authCollection);
		}
		
		return ret;
	}

	/**
	 * mypage
	 * @param userVO
	 * @param password
	 * @return
	 * @author jjong9950
	 */
	public int update(UserDetailsVO userVO, String password) {
		// TODO Auto-generated method stub
		
		Authentication oldAuth = SecurityContextHolder.getContext().getAuthentication();
		String encPassword = passwordEncoder.encode(password);
		log.debug("암호화된 패스워드인가" + encPassword);
		UserDetailsVO oldUserVO = (UserDetailsVO) oldAuth.getPrincipal();
		
//		oldUserVO.setPassword(encPassword);
		oldUserVO.setEmail(userVO.getEmail());
		oldUserVO.setPhone(userVO.getPhone());
		oldUserVO.setAddress(userVO.getAddress());
		
//		oldUserVO = UserDetailsVO.builder()
//				.password(encPassword)
//				.email(userVO.getEmail())
//				.phone(userVO.getPhone())
//				.address(userVO.getAddress())
//				.build();
		
		userVO.setPassword(encPassword);
		log.debug("서비스 유저VO : " + userVO.toString());
		// int ret = userDao.update(userVO);
//		int ret = userDao.update(oldUserVO);
		int ret = userDao.update(userVO);
		
		if(ret > 0) {
			Authentication newAuth = new UsernamePasswordAuthenticationToken(oldUserVO, 
							oldAuth.getCredentials(), oldAuth.getAuthorities());
			
			SecurityContextHolder.getContext().setAuthentication(newAuth);
		}
		
		return ret;
	}
	
	
	
}
