# 2026-02-12T21:08:21.355243
import vitis

client = vitis.create_client()
client.set_workspace(path="sw")

advanced_options = client.create_advanced_options_dict(dt_overlay="0")

platform = client.create_platform_component(name = "artyz7_platform",hw_design = "$COMPONENT_LOCATION/../../rtl/processor/top_level_wrapper.xsa",os = "standalone",cpu = "ps7_cortexa9_0",domain_name = "standalone_ps7_cortexa9_0",generate_dtb = False,advanced_options = advanced_options,compiler = "gcc")

comp = client.create_app_component(name="synthesizer",platform = "$COMPONENT_LOCATION/../artyz7_platform/export/artyz7_platform/artyz7_platform.xpfm",domain = "standalone_ps7_cortexa9_0")

comp = client.create_app_component(name="hello_world",platform = "$COMPONENT_LOCATION/../artyz7_platform/export/artyz7_platform/artyz7_platform.xpfm",domain = "standalone_ps7_cortexa9_0",template = "hello_world")

platform = client.get_component(name="artyz7_platform")
status = platform.build()

comp = client.get_component(name="synthesizer")
comp.build()

status = platform.build()

comp = client.get_component(name="hello_world")
comp.build()

status = platform.build()

client.delete_component(name="synthesizer")

client.delete_component(name="componentName")

status = platform.build()

comp.build()

comp = client.create_app_component(name="dma_loop_test",platform = "$COMPONENT_LOCATION/../artyz7_platform/export/artyz7_platform/artyz7_platform.xpfm",domain = "standalone_ps7_cortexa9_0")

status = platform.build()

comp = client.get_component(name="dma_loop_test")
comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp = client.get_component(name="hello_world")
comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp = client.get_component(name="dma_loop_test")
comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = comp.clean()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

