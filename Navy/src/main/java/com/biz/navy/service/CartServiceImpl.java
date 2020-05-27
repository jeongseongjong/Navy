package com.biz.navy.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.biz.navy.dao.CartDao;
import com.biz.navy.domain.CartListVO;
import com.biz.navy.domain.CartVO;
import com.biz.navy.domain.ColorVO;
import com.biz.navy.domain.SizeVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CartServiceImpl implements CartService{

	private final CartDao cartDao;

	@Override
	public List<CartVO> selectAll() {
		// TODO Auto-generated method stub
		return cartDao.selectAll();
	}

	@Override
	public List<CartVO> selectByStatus(String status) {

		return cartDao.selectByStatus(status);
	}
	
	@Override
	public int cartCount() {

		return cartDao.cartCount();
	}

	@Override
	public int countDelivery() {

		return cartDao.countDelivery();
	}

	@Override
	public List<CartVO> selectCart(String username) {

		return cartDao.selectCart(username);
	}

	@Override
	public List<CartVO> selectDelivery(String username) {

		return cartDao.selectDelivery(username);
	}

	@Override
	public int insert(CartVO cartVO) {

		cartVO.setBk_p_status("CART");
		return cartDao.insert(cartVO);
	}

	@Override
	public int qty_update(long bk_id, int bk_p_qty) {

		return cartDao.qty_update(bk_id, bk_p_qty);
	}

	@Override
	public int deleteOne(long longSeq) {

		return cartDao.delete(longSeq);
	}

	@Override
	public int cart_list_delete(List<String> seqList) {

		return cartDao.cart_list_delete(seqList);
	}

	@Transactional
	public void cart_list_qty_update(CartListVO cartList) {
		
		int nSize = cartList.getP_qty().size();
		for(int i = 0; i < nSize ; i++) {
			cartDao.qty_update(cartList.getSeq().get(i),
								cartList.getP_qty().get(i));
		}
		
	}
	@Override
	public int cart_to_delivery(List<String> buyList) {

		LocalDateTime ldt = LocalDateTime.now();
		DateTimeFormatter dt = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		
		String buyTime = ldt.format(dt).toString();
		List<CartVO> cartList = new ArrayList<CartVO>();
		for(String s : buyList) {
			
			CartVO cartVO = cartDao.findbyBkId(s);
			
			cartVO.setBk_p_buyTime(buyTime);
			
			cartList.add(cartVO);
		}
		return cartDao.cart_to_delivery(cartList);
	}

	@Override
	public String sum() {
		// TODO Auto-generated method stub
		return null;
	}

	// s_p_code로 사이즈를 조회하는 코드
	public List<SizeVO> findBySpCode(long s_p_code){
		
		return cartDao.findBySpCode(s_p_code);
	}

	public List<ColorVO> findByCsCode(long c_s_code) {

		return cartDao.findByCsCode(c_s_code);
	}



	
	

	
}
