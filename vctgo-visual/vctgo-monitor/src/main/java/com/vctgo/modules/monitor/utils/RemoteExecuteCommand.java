package com.vctgo.modules.monitor.utils;

import ch.ethz.ssh2.*;
import com.vctgo.common.core.utils.StringUtils;
import com.vctgo.modules.monitor.domain.ConnConfig;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

/**
 * @author: vctgo
 * @date: 2022/4/26 09:30
 * @description:
 */
@Slf4j
@Component
public class RemoteExecuteCommand {
    // 字符编码默认是utf-8
    public static final String CPU_MEM_SHELL = "top -b -n 1";
    public static final String FILES_SHELL = "df -hl";
    public static final String[] COMMANDS = {CPU_MEM_SHELL, FILES_SHELL};
    public static final String LINE_SEPARATOR = System.getProperty("line.separator");
    private static String DEFAULTCHART = "UTF-8";
    private Connection conn;
    private String ip;
    private String userName;
    private String userPwd;

    public String run(String cmd, ConnConfig connConfig) throws Exception {                //运行时直接调用的主方法，传入指令
        this.ip=connConfig.getIp();
        this.userName=connConfig.getUsername();
        this.userPwd=connConfig.getUserpwd();
        String execute = this.execute(cmd);    //可以将指令封装为一个枚举类以调用
        //System.out.println(execute);     //如果本机重启大可不必拿返回值，反正你都自爆了
        return execute;
    }

    public RemoteExecuteCommand() {

    }

    /**
     * 远程登录linux主机
     *
     * @return 登录成功返回true，否则返回false
     * @throws Exception
     * @since V0.1
     */
    public Boolean login() throws Exception {
        boolean flg = false;
        try {
            conn = new Connection(ip, 22);//22是默认端口号，如端口号改变的可以在这里更改
            // 连接
            conn.connect();
            // 认证
            flg = conn.authenticateWithPassword(userName, userPwd);
        } catch (IOException e) {
            throw new Exception("远程连接服务器失败", e);
        }
        return flg;
    }



    /**
     * 远程执行shll脚本或者命令
     *
     * @param cmd 即将执行的命令
     * @return 命令执行完后返回的结果值
     * @throws Exception
     * @since V0.1
     */
    public String execute(String cmd) throws Exception {
        String result = "";
        Session session = null;
        try {
            if (login()) {
                System.out.println("登录成功:");
                // 打开一个会话
                session = conn.openSession();
                // 执行命令
                session.execCommand(cmd);
                // processStdout(会话后续结果信息，编码状态);  自定义解析方法
                result = processStdout(session.getStdout(), DEFAULTCHART);
                // 如果为输出为空，说明脚本执行出错了
                if (StringUtils.isBlank(result)) {
                    result = processStdout(session.getStderr(), DEFAULTCHART);
                }
                System.out.println("exec has finished!");
                conn.close();
                session.close();
            }
        } catch (IOException e) {
            throw new Exception("命令执行失败", e);
        } finally {
            if (session != null) {
                session.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return result;
    }



    /**
     * 解析脚本执行返回的结果集
     *
     * @param in      输入流对象
     * @param charset 编码
     * @return 以纯文本的格式返回
     * @throws Exception
     * @since V0.1
     */
    private String processStdout(InputStream in, String charset) throws Exception {
        //  InputStream 字节输入流
        //StreamGobbler的作用是把session的标准输出包装成InputStream
        InputStream stdout = new StreamGobbler(in);
        StringBuffer buffer = new StringBuffer();
        // InputStreamReader  处理字符流的抽象类
        InputStreamReader isr = null;
        BufferedReader br = null;
        try {
            isr = new InputStreamReader(stdout, charset);//设置信息的编码格式
            br = new BufferedReader(isr);
            String line = null;
            //BufferedReader的readLine()方法是阻塞式的, 如果到达流末尾, 就返回null,
            while ((line = br.readLine()) != null) {
                buffer.append(line + "\n");
            }
        } catch (UnsupportedEncodingException e) {
            throw new Exception("不支持的编码字符集异常", e);
        } catch (IOException e) {
            throw new Exception("读取指令失败", e);
        } finally {
            br.close();
            isr.close();
            stdout.close();
        }
        return buffer.toString();
    }

    /**
     * 上传文件
     * 登录的用户权限不足会出错，将文件夹传给文件时会出错
     *
     * @param remoteFilePath 远程的文件地址
     * @param localFilePath  本地的文件地址
     * @return
     * */
    public boolean sftpDownload(String remoteFilePath, String localFilePath) throws Exception {
        File file = new File(localFilePath);
        boolean flag = false;
        SCPClient scp = null;
        //执行Linux命令查看系统中的Linux文件是否存在
        if (!execute("find " + remoteFilePath).equals(remoteFilePath + "\n")) {
            execute("cd /;mkdir " + remoteFilePath);//上传时远程的文件地址不存在就创建
        }
        //上传时本地的文件地址存在执行上传操作
        if (file.exists()) {
            try {
                if (login()) {
                    scp = conn.createSCPClient();
                    //将本地文件上传
                    scp.put(localFilePath, remoteFilePath);
                    flag = true;
                }
            } catch (IOException e) {
                flag = false;
                throw new Exception("文件地址错误！", e);
            } finally {
                if (conn != null) {
                    conn.close();
                }
            }
        }
        return flag;
    }

    /**
     * 下载文件
     * 登录的用户权限不足会出错，将文件夹传给文件时会出错
     *
     * @param remoteFilePath 远程文件地址
     * @param localFilePath  本地文件地址
     * @return
     */
    public boolean uoloadFile(String remoteFilePath, String localFilePath) throws Exception {
        File file = new File(localFilePath);
        boolean flag = false;
        SCPClient scp = null;
        //判断本地中的地址是否存在
        if (!file.exists() && !file.isDirectory()) {
            file.mkdir();//下载时如果本地文件地址不存在，就创建
        }
        //如果远程文件地址存在刚执行文件传输
        if (execute("find " + remoteFilePath).equals(remoteFilePath + "\n")) {
            log.debug("远程文件地址:  " + execute("find " + remoteFilePath));
            try {
                if (login()) {
                    scp = conn.createSCPClient();
                    scp.get(remoteFilePath, localFilePath);
                    flag = true;
                }
            } catch (IOException e) {
                flag = false;
                throw new Exception("文件地址错误！", e);
            } finally {
                if (conn != null) {
                    conn.close();
                }
            }
        }
        return flag;
    }


    /**
     * 安装jdk
     * @param localFilePath  本地的jdk路径
     * @param remoteFilePath 远程jdk地址
     * @return
     */
    public boolean installationJDK(String remoteFilePath, String localFilePath) throws Exception {
        boolean flag ;
        File file = new File(localFilePath);
        String name = file.getName();//获取上传jdk压缩包的名字，方便解压操作
        String absolutePath = file.getParent();//获取的本地jdk压缩包的路径
        //将文件上传
        flag = sftpDownload(remoteFilePath, localFilePath);
        if (flag) {
            //上传成功后，将文件解压并删除jdk压缩包；多条命令执行以  ;  隔开
            execute("cd " + remoteFilePath + ";tar -zxvf " + name + ";rm -rf " + name);
            //jdkName存放Linux系统下的jdk的绝对地址
            String jdkName = execute("find " + remoteFilePath + " -maxdepth 1 -name \"jdk*\"");
            //jdkName是返回字符串后面会带\n
            jdkName = jdkName.replaceAll("\n", "");
            flag = uoloadFile("/etc/profile", absolutePath);
            //如果上传成功
            if (flag) {
                //将下载下来配置文件地址给absolutePath
                absolutePath = absolutePath + "\\profile";
                List<String> fileContent = new ArrayList<>();
                fileContent.add("export JAVA_HOME=" + jdkName);
                fileContent.add("\nexport JRE_HOME=${JAVA_HOME}/jre");
                fileContent.add("\nexport CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib");
                fileContent.add("\nexport PATH=${JAVA_HOME}/bin:$PATH");
                //writeFile为自定义方法
                flag = writeFile(absolutePath, fileContent);
                if (flag) {
                    flag = sftpDownload("/etc/", absolutePath);
                    if (flag) {
                        //设置将jdk设置为系统默认
                        execute("rm -rf /usr/bin/java;rm -rf /usr/bin/javac;rm -rf /etc/alternatives");
                        execute("cd /usr/bin;ln -sf "+jdkName+"/bin/java /usr/bin/java");
                        execute("ln -sf "+jdkName+"/bin/java  /usr/bin/javac");
                        execute("source /etc/profile");
                        if(!execute("java -version").contains("java version")){
                            flag=false;
                        }
                    }
                }
            }
        }
        return flag;
    }

    /**
     * 写入文件
     * @param localFilePath 本地文件地址
     * @param fileContent   写入文件的内容
     * @return
     */
    public boolean writeFile(String localFilePath, List<String> fileContent) throws IOException {
        File file = new File(localFilePath);
        //如果本地文件不存在将不执行
        if (!file.exists()) {
            return false;
        }
        OutputStream fileOut = null;
        PrintWriter pw = null;
        try {
            fileOut = new FileOutputStream(localFilePath, true);//true是对文件进行追加
            pw = new PrintWriter(fileOut);
            for (String conten : fileContent) {
                pw.print(conten);
            }
            pw.flush();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            pw.close();
            fileOut.close();
        }
        return true;
    }


}
