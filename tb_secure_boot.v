module tb_secure_boot;

    reg clk;
    reg power_on;
    wire boot_ok;
    wire boot_fail;

    secure_boot uut (
        .clk(clk),
        .power_on(power_on),
        .boot_ok(boot_ok),
        .boot_fail(boot_fail)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        power_on = 0;

        $display("Time\tPower\tBoot_OK\tBoot_Fail");

        #10 power_on = 1;

        #10 $display("%0t\t%b\t%b\t%b", $time, power_on, boot_ok, boot_fail);
        #20 $display("%0t\t%b\t%b\t%b", $time, power_on, boot_ok, boot_fail);

        #20 $finish;
    end

endmodule

