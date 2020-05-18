package com.biz.navy.service;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.biz.navy.dao.CartDao;
import com.biz.navy.domain.CartListVO;
import com.biz.navy.domain.CartVO;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class CartServiceImpl implements CartService{

	private final CartDao cartDao;

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
	public CartVO insert(CartVO cartVO) {

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
	public Integer cart_to_delivery(List<String> buyList) {

		return cartDao.cart_to_delivery(buyList);
	}

	@Override
	public String sum() {
		// TODO Auto-generated method stub
		return null;
	}
	
	

	
}
