<#assign params = params!>
<#assign name = name!>
<#assign package = package!>
/**
 * WARNING: THIS FILE IS AUTOGENERATED!
 */
package ${package} {
<#if params?has_content>
    <#assign argNames = params?keys>
    <#list argNames as arg>
        <#assign dispatchClass = params[arg]>
        <#if dispatchClass?split(".")?size != 1 >
import ${params[arg]};
        </#if>
    </#list>
</#if>

public interface I${name?cap_first}Handler {
	function handle${name?cap_first}(<#if params?has_content><#assign argNames = params?keys><#list argNames as arg>${arg}:${params[arg]}<#if arg_has_next>, </#if></#list></#if>):void;
}
}
