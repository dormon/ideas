float fce(float y,float x){
  return 1.f/(y*y)-x;
}

float diff(float y){
  return -2.f/(y*y*y);
}

bool line(vec3 l,vec2 uv){
  return abs(dot(l,vec3(uv,1)))<0.01f;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    float aspect = iResolution.x / iResolution.y;
    vec2 uv = (fragCoord/iResolution.xy-.5f)*10.f*vec2(1.f,aspect);
    
    float x     = (iMouse.y)/iResolution.y*2.f;
    
    int   i     = floatBitsToInt(x);
    i           = 0x5f3759df - (i>>1);
    float guess = intBitsToFloat(i);
    
    
    
    vec4 c=vec4(1.f);
    
    float ff = float(pow(abs(fce(uv.x,x)-uv.y),.7f)<0.1);
    if(ff>0.f && uv.x>0.f)c=vec4(1,0,0,0);
    
    if(abs(uv.y) < 0.03f)c=vec4(0.f);
    if(abs(uv.x) < 0.01f)c=vec4(0.f);
    if(abs(uv.x-guess) < 0.01f)c=vec4(0,1,0,1); 
    
    
    vec3 lin = vec3(diff(guess),-1,0);
    lin.z = -dot(lin.xy,vec2(guess,fce(guess,x)));
    if(line(lin,uv))c=vec4(0,0,1,1);
    
    fragColor = vec4(c);
}
