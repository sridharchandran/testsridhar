package com.onwardpath.wem.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.onwardpath.wem.entity.Popup;
import com.onwardpath.wem.entity.PopupAttributes;

public interface PopupAttrRepository extends JpaRepository<PopupAttributes, Integer> {

}
