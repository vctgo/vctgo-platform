package com.vctgo.system.domain;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotNull;

@ApiModel("管理后台 - 套餐包精简信息")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class SysSimplePackage {

    @ApiModelProperty(value = "套餐编号", required = true, example = "1024")
    private Long id;

    @ApiModelProperty(value = "套餐名称", required = true, example = "芋道")
    private String name;

}
