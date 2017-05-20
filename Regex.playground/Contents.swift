//: Playground - noun: a place where people can play

import Foundation
//  邮箱验证
func validateEmail(email: String) -> Bool {
	let emailString = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
	let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailString)
	return emailPredicate.evaluate(with: email)
}

validateEmail(email: "xiayao.zeng@gmail.com")

//  手机号验证
func validatePhonoNum(phono: String) -> Bool {
	//手机号以13x,15x(不包括154),17x,18x开头，八个数字字符
//	let phoneString = "^((13[0-9])|(15[^4,\\D]) |(17[0,0-9])|(18[0,0-9]))\\d{8}$"
//	let phoneString = "^((13[0-9])|(15[^4, \\D])|(17[0,0-9])|(18[0,0-9]))\\d{8}$"
	let phoneString = "^((13[0-9])|15[^4, \\d])|(17[0-9])|(18([0,9]))\\d{8}$"
	let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneString)
	return phonePredicate.evaluate(with: phono)
}

validatePhonoNum(phono: "18917389375")

func validateUserName(name: String) -> Bool {
	let userNameRegex = "^[A-Za-z0-9]{6,20}+$"
	let userNamePredicate = NSPredicate(format: "SELF MATCHES %@", userNameRegex)
	let peopleName = userNamePredicate.evaluate(with: name)
	return peopleName
}


validateUserName(name: "xiayao")

func validatePassword(passWord: String) -> Bool {
	let  passWordRegex = "^[a-zA-Z0-9]{6,20}+$"
	let passWordPredicate = NSPredicate(format: "SELF MATCHES %@", passWordRegex)
	return passWordPredicate.evaluate(with: passWord)
}

validatePassword(passWord: "456789")

func validateNickname(nickname: String) -> Bool {
	let nicknameRegex = "^[\u{4e00}-\u{9fa5}]{4,8}$"
	let passWordPredicate = NSPredicate(format: "SELF MATCHES%@", nicknameRegex)
	return passWordPredicate.evaluate(with: nickname)
}

validateNickname(nickname: "夏瑶")

func validateCarNum(car: String) -> Bool {
	let carString = "^[A-Za-z]{1}[A-Za-z_0-9]{5}$"
	let carPredicate = NSPredicate(format: "SELF MATCHES %@", carString)
	return carPredicate.evaluate(with: car)
}
