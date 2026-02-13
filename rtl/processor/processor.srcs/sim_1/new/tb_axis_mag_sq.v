module tb_axis_mag_sq;

  parameter W = 16;

  reg aclk = 0;
  always #5 aclk = ~aclk;

  reg aresetn = 0;

  reg  [2*W-1:0] s_axis_tdata  = 0;
  reg            s_axis_tvalid = 0;
  wire           s_axis_tready;
  reg            s_axis_tlast  = 0;

  wire [2*W-1:0] m_axis_tdata;
  wire           m_axis_tvalid;
  reg            m_axis_tready = 1;
  wire           m_axis_tlast;

  magnitude #(.W(W)) dut (
    .aclk(aclk),
    .aresetn(aresetn),

    .s_axis_tdata(s_axis_tdata),
    .s_axis_tvalid(s_axis_tvalid),
    .s_axis_tready(s_axis_tready),
    .s_axis_tlast(s_axis_tlast),

    .m_axis_tdata(m_axis_tdata),
    .m_axis_tvalid(m_axis_tvalid),
    .m_axis_tready(m_axis_tready),
    .m_axis_tlast(m_axis_tlast)
  );

  function [2*W-1:0] pack;
    input integer re;
    input integer im;
    reg signed [W-1:0] r;
    reg signed [W-1:0] i;
    begin
      r = re;
      i = im;
      pack = {i[W-1:0], r[W-1:0]};
    end
  endfunction

  task send_one;
    input integer re;
    input integer im;
    input last;
    begin
      s_axis_tdata  = pack(re, im);
      s_axis_tlast  = last;
      s_axis_tvalid = 1;

      // wait for input handshake at a clock edge
      while (!(s_axis_tvalid && s_axis_tready)) @(posedge aclk);

      // drop after handshake
      @(posedge aclk);
      s_axis_tvalid = 0;
      s_axis_tlast  = 0;
    end
  endtask

  task wait_out_and_print;
    input [255:0] tag;
    begin
      // Wait for OUTPUT handshake at a clock edge
      while (!(m_axis_tvalid && m_axis_tready)) @(posedge aclk);

      // Print on the cycle of handshake (data/last are valid here)
      $display("%s OUT data=%0d (0x%h) TLAST=%0d time=%0t",
               tag, m_axis_tdata, m_axis_tdata, m_axis_tlast, $time);

      // advance one cycle so next wait doesn't re-trigger on same beat
      @(posedge aclk);
    end
  endtask

  initial begin
    // reset
    repeat (5) @(posedge aclk);
    aresetn = 0;
    repeat (10) @(posedge aclk);
    aresetn = 1;
    repeat (5) @(posedge aclk);

    // Keep ready high always for now
    m_axis_tready = 1;

    // (3,4): expected (25 >> 1) = 12 with your scaling
    send_one(3, 4, 0);
    wait_out_and_print("A");

    // (7,-2): expected (53 >> 1) = 26, TLAST should be 1
    send_one(7, -2, 1);
    wait_out_and_print("B");

    $display("Done.");
    #50;
    $finish;
  end

endmodule